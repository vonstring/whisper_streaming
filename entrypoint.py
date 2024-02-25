import sys
from faster_whisper.utils import download_model

model_name = "NbAiLab/nb-whisper-large"

for i, arg in enumerate(sys.argv):
    if arg == "--model" and len(sys.argv) > i + 1:
        model_name = sys.argv[i+1]
        # remove the model name from the arguments
        sys.argv.pop(i+1)
        sys.argv.pop(i)
        break

target_dir = "/models"

model_dir = download_model(model_name, cache_dir=target_dir)
sys.argv += ['--model_dir', model_dir]

import whisper_online_server