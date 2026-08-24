from __future__ import annotations

import subprocess
import tempfile
import unittest
from pathlib import Path


PREVIEW_SCRIPT = Path(__file__).resolve().parents[1] / "scripts" / "preview.mjs"


class PreviewTestCase(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        (self.root / "base.md").write_text(
            "---\n"
            "tipo: checkpoint\n"
            "identificador: checkpoint-teste\n"
            "titulo: Checkpoint de teste\n"
            "pontos_totais: 100\n"
            "---\n\n"
            "# Cenário\n\n"
            "```java\npublic class Exemplo {}\n```\n\n"
            "## Q01 [100 pontos]\n\nEnunciado.\n",
            encoding="utf-8",
        )

    def tearDown(self) -> None:
        self.temporary.cleanup()

    def run_preview(self, command: str) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            ["node", str(PREVIEW_SCRIPT), command, str(self.root)],
            capture_output=True,
            text=True,
            check=False,
        )

    def test_generate_creates_readable_preview_and_check_accepts_it(self) -> None:
        generated = self.run_preview("generate")
        self.assertEqual(0, generated.returncode, generated.stderr)
        preview = (self.root / "preview" / "base.html").read_text(encoding="utf-8")
        self.assertIn("assessment-source-sha256", preview)
        self.assertIn('class="hljs-keyword"', preview)
        self.assertNotIn("pontos_totais: 100", preview)
        checked = self.run_preview("check")
        self.assertEqual(0, checked.returncode, checked.stderr)

    def test_check_rejects_preview_after_source_change(self) -> None:
        self.assertEqual(0, self.run_preview("generate").returncode)
        with (self.root / "base.md").open("a", encoding="utf-8") as stream:
            stream.write("\nMudança sem regeneração.\n")
        checked = self.run_preview("check")
        self.assertNotEqual(0, checked.returncode)
        self.assertIn("preview divergente", checked.stderr)

    def test_generate_replaces_stale_preview(self) -> None:
        self.assertEqual(0, self.run_preview("generate").returncode)
        with (self.root / "base.md").open("a", encoding="utf-8") as stream:
            stream.write("\nMudança regenerada.\n")
        self.assertEqual(0, self.run_preview("generate").returncode)
        self.assertEqual(0, self.run_preview("check").returncode)


if __name__ == "__main__":
    unittest.main()
