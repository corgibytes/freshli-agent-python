import os

class DetectManifestsCommand:
    def __init__(self, project_path):
        self.project_path = project_path
    
    def execute(self) -> list[str]:
        targets = ["requirements.txt", "Pipfile.lock", "poetry.lock"]

        result = []

        for current_dir, _, files in os.walk(self.project_path):
            for file in files:
                if file in targets:
                    result.append(os.path.join(current_dir, file))

        return sorted(result)
