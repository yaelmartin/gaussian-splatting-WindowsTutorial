# Windows easier script

- Read both files, change the paths according to your setup
- Edit the parameters to your liking


# Windows - Gaussian Splatting

[https://github.com/graphdeco-inria/gaussian-splatting](https://github.com/graphdeco-inria/gaussian-splatting)

### *Tutorial inspired by*

- **The NeRF Guru** [https://www.youtube.com/watch?v=UXtuigy_wYc](https://www.youtube.com/watch?v=UXtuigy_wYc)
- **Maftej** [https://github.com/graphdeco-inria/gaussian-splatting/issues/493](https://github.com/graphdeco-inria/gaussian-splatting/issues/493)

As this tutorial only focuses on getting the original paper’s code to run on Windows, in order to train your own scene, you will need aligned photos and point cloud in the COLMAP undistorded format.

```jsx
<location>
|---images
|   |---<image 0>
|   |---<image 1>
|   |---...
|---sparse
    |---0
        |---cameras.bin
        |---images.bin
        |---points3D.bin
```

You can use converted projects from Metashape Pro to COLMAP format using a python script.

[https://github.com/PolarNick239/gaussian-splatting-Windows#preparing-images-from-your-own-scenes-agisoft-metashape-pro](https://github.com/PolarNick239/gaussian-splatting-Windows#preparing-images-from-your-own-scenes-agisoft-metashape-pro)

[https://github.com/agisoft-llc/metashape-scripts/blob/master/src/export_for_gaussian_splatting.py](https://github.com/agisoft-llc/metashape-scripts/blob/master/src/export_for_gaussian_splatting.py)

# Requirements

- Up-to-date windows 10-11
- Up-to-date motherboard drivers/chipset
- NVIDIA GPU with driver version >=452.39
[https://www.nvidia.com/download/index.aspx](https://www.nvidia.com/download/index.aspx)

## QoL

- fast internet
- fast SSD, high end CPU and high VRAM GPU

# Downloads

- Git [https://git-scm.com/download/win](https://git-scm.com/download/win)
- Python/Anaconda [https://www.anaconda.com/download](https://www.anaconda.com/download)
- Visual Studio 2019 Community
[https://my.visualstudio.com/Downloads?q=visual studio 2019&wt.mc_id=o~msft~vscom~older-downloads](https://my.visualstudio.com/Downloads?q=visual%20studio%202019&wt.mc_id=o~msft~vscom~older-downloads)
- Cuda 11.8
[https://developer.nvidia.com/cuda-11-8-0-download-archive?target_os=Windows&target_arch=x86_64](https://developer.nvidia.com/cuda-11-8-0-download-archive?target_os=Windows&target_arch=x86_64)
- GS viewer
[https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/binaries/viewers.zip](https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/binaries/viewers.zip)

# Installing required softwares

## Visual Studio Code 2019

Run the installer and select the option “Desktop development with C++”

### Anaconda

Install for all users and don’t add the Path when asked.

### Cuda 11.8

Install Cuda 11.8 after Visual Studio 2019.
Choose custom installation, and untick

- NVIDIA Geforce Experience
- Other components
- Driver components

# System variables

Launch with **Win+r** or search “System Properties”
****C:\Windows\System32\SystemPropertiesAdvanced.exe

Add these to System variables

- CUDA_HOME
C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8
- CUDA_PATH
C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8
- CUDA_PATH_V11_8
C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8

Add these to Path

- C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin
- C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\libnvvp
- C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.29.30133\include
- C:\ProgramData\anaconda3\condabin\conda.bat
- C:\ProgramData\anaconda3\Librar

# Cloning the github repository

Launch a Terminal and run these commands, one at a time

```jsx
cd "AbsolutePathToYourDesiredFolder"
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
```

# Creating the conda environment and installing its dependencies

Launch a Terminal instance from Anaconda Navigator GUI
Environments > base (root) > Play button > Open Terminal

Run these commands, one at a time

```jsx
cd "AbsolutePathToYourGaussianSplattingFolder"
conda create -n gs python=3.10
conda activate gs
python -m pip install --upgrade pip --user
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install plyfile
pip3 install tqdm
cd submodules
pip install .
```

# Final steps before training

Unzip the viewers.zip file in the “gaussian-splatting” folder.

I like to have my COLMAP datasets in a folder named “data” in the “gaussian-splatting” folder. 

# Training

To make training easier, I used GPT4 to create a simple .bat file.
Download the files here, then place them in your “gaussian-splatting” folder.
When double-clicking “cli-main.bat”, arguments are retrieved from “cli-train-settings.txt” which contains common settings that can be modified easely.

/!\ you must disable sleep in your PC Power & sleep settings, or the training will be paused!

```jsx
#Comments MUST be on a line starting by the # character.

#Reduce VRAM consumption, but slightly slow down training.
--data_device cpu

#How many iterations to train the scene
--iterations 60000
# don't forget to save when reaching your desired max number of iterations!
--save_iterations 3000 6000 12000 15000 18000 21000 24000 26000 28000 30000 32000 34000 36000 38000 40000 42000 44000 46000 48000 50000 52000 54000 55000 56000 58000 60000

#If provided 1, 2, 4 or 8, uses original, 1/2, 1/4 or 1/8 resolution
#--resolution 2
```

60k iterations is overkill, you won’t notice much improvements and you can even get overtrained scenes with weird straight thin splats.

By default, the train.py use a random string for the ouput of your scene. My .bat file will keep your source folder name.

More advanced arguments can be used, see the original github page.
[https://github.com/graphdeco-inria/gaussian-splatting#:~:text=command line arguments for train.py](https://github.com/graphdeco-inria/gaussian-splatting#:~:text=command%20line%20arguments%20for%20train.py)

# View the scene during training

Navigate and run the remote viewer located at “gaussian-splatting\viewers\bin\SIBR_remoteGaussian_app.exe”

On the top left, disable training if you want to navigate with smooth FPS. Don’t forget to enable the training back or quit the viewer afterward.
I like to use trackball navigation.

# View a .ply scene after training

### Using a web viewer (easier)

I like to use this viewer [https://projects.markkellogg.org/threejs/demo_gaussian_splats_3d.php](https://projects.markkellogg.org/threejs/demo_gaussian_splats_3d.php)
Simply choose your “point_cloud.ply” file located in “output\YourScanFolder\point_cloud\iteration_XXXXX” and click view.

### Using the provided viewers (more difficult)

You can’t just double-click the viewer like before, you must use the Terminal.

```jsx
cd "AbsolutePathToYourGaussianSplattingFolder"
viewers\bin\SIBR_gaussianViewer_app.exe -m "PathToYourOuputedSceneFolder"
#you can also use modify the render resolution
viewers\bin\SIBR_gaussianViewer_app.exe --rendering-size 1900 1000 --force-aspect-ratio -m "PathToYourOuputedSceneFolder"
```

### In VR using Gracia.ai

[Gracia.ai](http://Gracia.ai) allows you to explore splats in VR on Windows.

### Additionnal useful tools

- If you want to do reuse resized pictures instead of the train.py command doing it each time, you can use XnView to batch resize them [https://www.xnview.com/en/](https://www.xnview.com/en/)