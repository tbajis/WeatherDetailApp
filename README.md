# WeatherDetailApp
## Mobile Code-a-Thon 2019 Project
*This project is a basic weather detail app that displays a weather forecase for a particular location. This app is meant to teach basic to intermediate concepts of iOS development.*

### Setup
In order to get started with this project, please make sure that you have Xcode downloaded and installed on your computer. You can find the download link [here](https://developer.apple.com/xcode/).

If you are working on a Mac (and you should be for this project!), you should already have Git installed.  
To check, open "Terminal" from your Launchpad, type `git version`, and hit Enter.  
You should see output similar to `git version 2.20.1 (Apple Git-117)`.  
If you don't have Git installed, please install it following the directions [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).  

Make sure that you have access to the Dark Sky Weather API. If you haven't signed up already, please do so [here](https://darksky.net/dev).  
You will need your API key to use the network client of this project.

### Git Commands
Throughout this course, we will use a few different Git commands. Please take a look at this crash course if you are unfamiliar with them! We will be using Terminal to execute all of these commands.

**[git clone](https://git-scm.com/docs/git-clone)**  
Clone a repository (normally remote) into a specific directory on your computer.  
Execute `pwd` in Terminal first. The output (your current directory) is where this Git repo will be cloned into.

example: `git clone https://github.com/womenwhocode/mobile-code-a-thon-ios.git`

**[git checkout](https://git-scm.com/docs/git-checkout)**  
Switch branches (optionally creating a new branch), or update files in the working tree to match a specific version.

to create a new branch: `git checkout -b my-new-branch-name`  
to checkout an existing branch: `git checkout my-existing-branch-name`  
to checkout a specific commit: `git checkout <insert commit hash here>`  

**[git reset](https://git-scm.com/docs/git-reset)**  
Reset the current HEAD to a specific state, often throwing out your un-committed changes.  

to throw away all uncommitted changes: `git reset --hard HEAD`  

**[git status](https://git-scm.com/docs/git-status)**  
Show the status of your current working tree. Use this to see the state of your local repo.

example: `git status`

**[git add](https://git-scm.com/docs/git-add)**  
Stage files to be committed (aka add files to the index).

to stage all files: `git add .`  
to stage a specific file: `git add /path/to/specific/file`  

**[git commit](https://git-scm.com/docs/git-commit)**  
Record changes to the repository (your local one).

to edit the commit message in a text editor: `git commit`  
to append a one-line commit message: `git commit -m 'your commit message here'`

### Getting Started
First, open Terminal and `cd` to the directory where this project will live. Then, clone the project using Git.  
`git clone https://github.com/womenwhocode/mobile-code-a-thon-ios.git`  

Now, use Git to checkout the branch beginner-step-1.  
`git checkout beginner-step-1`

After this is done, navigate to the project directory in Finder and open the Weather.xcodeproj file. This will open the entire project in Xcode. You're now ready to begin development!

### If You Get Lost
If you want to jump to a specific point in the project, you have a few options.  

1. Delete all of your un-committed changes and jump to a checkpoint.  
To do this, execute the following commands. Make sure to read about **git reset** above first!  
`git reset --hard HEAD`  
`git checkout branch-that-you-want-to-jump-to`  

2. Save your un-committed changes and jump to a checkpoint.  
Execute the following commands. Make sure to read about **git commit** above first!  
`git add .`  
`git commit -m 'your commit message here'`  
`git checkout branch-that-you-want-to-jump-to`  
