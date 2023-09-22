# Our solution for the MedFM: Foundation Model Prompting for Medical Image Classification Challenge 2023

**Authors:** [@Tianyi Wang<sup>*</sup>](https://github.com/TianyiFranklinWang), [@Mengkang Lu<sup>*</sup>](https://github.com/PathBOT-Admin), [@Yong Xia<sup>✉️</sup>](https://scholar.google.com/citations?user=Usw1jeMAAAAJ&hl=en)

**Institute:** National Engineering Laboratory for Integrated Aero-Space-Ground-Ocean Big Data Application Technology, School of Computer Science and Engineering, Northwestern Polytechnical University, Xi’an 710072, China

## Roadmap

- Update the final solution: ✔️
- Upload the solution paper: ✔️
- Make the initial ReadMe: ✔️
- Document code: 🚧
- Release the source code: 🚧
- Update ReadMe: 🚧

## Introduction

Please check our [paper](./docs/MedFM_Solution.pdf) for more details.

## Getting Started

### Clone the repository
```bash
git clone https://github.com/TianyiFranklinWang/MedFM_Submission_Only.git
```
### Setup environment

Python version: 3.8.17 **(make sure to use compatible versions as other versions may encounter issues)**

**Make sure you are using Linux distributions as the codes are platform bundled**

```bash
python -m pip install -r requirements.txt
```

**You may encounter errors installing PyTorch please follow [the official guide](https://pytorch.org/get-started/previous-versions/#:~:text=%23%20CUDA%2011.1%0Apip%20install%20torch%3D%3D1.9.1%2Bcu111%20torchvision%3D%3D0.10.1%2Bcu111%20torchaudio%3D%3D0.9.1%20%2Df%20https%3A//download.pytorch.org/whl/torch_stable.html) to install**

### Prepare data

- Download the [file lists](https://github.com/openmedlab/MedFM/tree/main/data_backup/MedFMC) from the official repo and place them under the data folder.
- Create a folder named `images` under every sub-directory in MedFMC.
- Put all image files under `images`.
- The final structure should look like this:
  ```bash
  data
  └── MedFMC
      ├── chest
      │   ├── images
      │   │   └── ***.png
      │   └── ***.txt
      ├── colon
      │   ├── images
      │   │   └── ***.png
      │   └── ***.txt
      └── endo
          ├── images
          │   └── ***.png
          └── ***.txt
  ```
  *Tips: Using `ln -s TARGET LINK_NAME` to create symbolic links may ease your work if you already have your data elsewhere.*

### Download model weight

- Download the open-sourced model weight from [Google Drive](https://drive.google.com/file/d/14MSSwMgC52UGbUcFnJwnsPa79LrMplqK/view?usp=sharing).
- Create a `pretrain` folder and put the weight file underneath it.

**The official weight file link will be revealed with the source code soon.**

### Train models

Use `run.sh` to train your models. The usage of the script is as follows:
```bash
./run.sh EXP_TYPE EXP_NUM SHOT_NUM DATA_TYPE

EXP_TYPE in 'no-ema_no-aug' 'no-ema_aug' 'ema_aug'
EXP_NUM in 1 2 3 4 5
SHOT_NUM in 1 5 10
DATA_TYPE in 'chest' 'colon' 'endo'
```
Note that for `EXP_TYPE` `ema_aug`, we only need to run 1-shot colon experiments. For the other two `EXP_TYPE` all combinations of `SHOT_NUM` and `DATA_TYPE` should be run.

The full list of experiments (**95** in total) required is as follows:
```bash
./run.sh [no-ema_no-aug no-ema_aug] [1 2 3 4 5] [1 5 10] [chest endo colon]
./run.sh [ema_aug] [1 2 3 4 5] [1] [colon]
```

### Inference on test set

Use `test.sh` to infer your models. The usage of the script is as follows:
```bash
./test.sh EXP_TYPE EXP_NUM SHOT_NUM DATA_TYPE DEVICE_ID

EXP_TYPE in 'no-ema_no-aug' 'no-ema_aug' 'ema_aug'
EXP_NUM in 1 2 3 4 5
SHOT_NUM in 1 5 10
DATA_TYPE in 'chest' 'colon' 'endo'
# DEVICE_ID is your cuda device id
```

The full list of inferences (**95** in total) required is as follows:
```bash
./test.sh [no-ema_no-aug no-ema_aug] [1 2 3 4 5] [1 5 10] [chest endo colon] DEVICE_ID
./test.sh [ema_aug] [1 2 3 4 5] [1] [colon] DEVICE_ID
```

### Ensemble results

There are two stages to form the final submission:
- Ensemble `no-ema_no-aug` results with `no-ema_aug` results.
  ```bash
  python ./tools/ensemble_no-ema_no-aug_with_aug.pyc
  ```
- Ensemble `ema_aug` results with the output from the previous stage.
  ```bash
  python ./tools/ensemble_no-ema_with_ema.pyc
  ```

## Code Structure

If you wish to dive into the code, the source code will be available in the near future. Right now, the naming should be straightforward. The structure is as follows:
```bash
MedFM_Submission_Only
├── CITATION.cff                              # Configuration for citation
├── LICENSE                                   # License
├── README.md                                 # ReadMe
├── configs                                   # Configurations
├── docs
│   └── MedFM_Solution.pdf                    # Detailed solution paper
├── medfmc
│   └── models
│       ├── adapt_beit.pyc                    # Model with adapter
│       └── beit.pyc                          # Vanilla model
├── pyarmor_runtime_000000                    # Distribution related runtime
├── requirements.txt                          # Dependencies
├── run.sh                                    # Bash script for training
├── test.sh                                   # Bash script for testing
└── tools
    ├── ensemble_no-ema_no-aug_with_aug.pyc   # Ensemble no-ema_no-aug with no-ema-aug
    ├── ensemble_no-ema_with_ema.pyc          # Ensemble no-ema_aug with ema_aug
    ├── test_prediction.pyc                   # Vanilla test script
    ├── test_prediction_tta.pyc               # Test script with TTA
    └── train.pyc                             # Training script
```

## License

This project is released under the [Apache 2.0 license](./LICENSE).

## Citation

This citation is only for this repository.

### BibTex
```bibtex
@software{Wang_MedFM_Submission_Only,
author = {Wang, Tianyi and Lu, Mengkang and Xia, Yong},
license = {Apache-2.0},
title = {{MedFM_Submission_Only}},
url = {https://github.com/TianyiFranklinWang/MedFM_Submission_Only}
}
```
