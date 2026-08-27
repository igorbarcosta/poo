from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


POO_ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = POO_ROOT / "avaliacoes" / "scripts"
sys.path.insert(0, str(SCRIPTS))
import workflow  # noqa: E402


class DocemasIntegrationTestCase(unittest.TestCase):
    def test_wrapper_loads_sibling_docemas(self) -> None:
        expected = POO_ROOT.parent / "docemas" / "assessments" / "scripts" / "workflow.py"
        self.assertEqual(expected.resolve(), workflow.DOCEMAS_MODULE_PATH)
        self.assertTrue(workflow.DOCEMAS_MODULE_PATH.is_file())

    def test_historical_checkpoint_replay_remains_valid(self) -> None:
        root = POO_ROOT / "avaliacoes" / "checkpoints" / "checkpoint-01-replay"
        self.assertEqual([], workflow.validate(root, workflow.load_workflow(root / "workflow.yaml")))

    def test_docemas_template_can_start_a_poo_instrument(self) -> None:
        template = workflow.DOCEMAS_ROOT / "assessments" / "templates" / "instrument"
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for name in ("workflow.yaml", "blueprint.md", "base.md", "base-review.md"):
                shutil.copy2(template / name, root / name)
            result = subprocess.run(
                ["node", str(SCRIPTS / "preview.mjs"), "generate", str(root)],
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(0, result.returncode, result.stderr)
            self.assertEqual([], workflow.validate(root, workflow.load_workflow(root / "workflow.yaml")))

    def test_poo_cli_delegates_validation_to_docemas(self) -> None:
        root = POO_ROOT / "avaliacoes" / "checkpoints" / "checkpoint-01-replay"
        result = subprocess.run(
            [sys.executable, str(SCRIPTS / "workflow.py"), "validate", str(root)],
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertIn("valid workflow", result.stdout)


if __name__ == "__main__":
    unittest.main()
