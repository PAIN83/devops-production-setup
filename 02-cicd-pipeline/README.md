# Project 2 — CI/CD Pipeline with GitHub Actions

## What is this project?
Before this project, deploying an update meant:
  1. SSH into the server manually
  2. Pull the latest code
  3. Restart the app
  4. Hope nothing breaks

That is how nobody should work in 2024. This project automates
all of that — you push code to GitHub and the server updates
itself. No SSH, no manual steps, no human error.

## How it works (simple explanation)
Think of GitHub Actions as a robot that watches your repo.
The moment you push code it wakes up and follows a set of
instructions you wrote. In our case those instructions are:
  - Connect to the EC2 server via SSH
  - Download the latest code
  - Package the app into a Docker container
  - Replace the old running container with the new one
  - App is live with the latest changes

## The full flow
You type: git push
        ↓
GitHub Actions robot wakes up
        ↓
SSHs into EC2 automatically
        ↓
Pulls your latest code from GitHub
        ↓
Builds a fresh Docker image from the Dockerfile
        ↓
Kills the old container
        ↓
Starts the new container on port 80
        ↓
Your updated app is live — took about 60 seconds total

## What is Docker and why we use it
Without Docker, the app might work on your laptop but
break on the server because of different Python versions,
OS differences, missing packages etc.

Docker packages your app AND everything it needs into
one container. It runs exactly the same everywhere.

Image  = the recipe (built from Dockerfile)
Container = the running app made from that recipe

## Files explained
- app.py
    The actual web app. Built with Flask (Python).
    Has two endpoints:
      /        shows the main webpage
      /health  returns {"status":"healthy"} — used to check
               if the app is alive (standard in production)

- requirements.txt
    The shopping list for Python packages.
    Docker reads this and installs Flask before starting the app.

- Dockerfile
    Step by step instructions to build the Docker image:
      Start with Python 3.11
      Set working folder to /app
      Install Flask from requirements.txt
      Copy app code
      Open port 5000
      Start the app

- .github/workflows/deploy.yml
    The pipeline file. GitHub automatically reads this folder.
    Defines what happens on every git push to master branch.

## Challenges I faced and how I fixed them

Challenge 1 — Dockerfile not found
  The pipeline script was looking for Dockerfile in the wrong
  folder. Fixed by adding "cd 02-cicd-pipeline" to the script
  before building the image.

Challenge 2 — Port 80 already in use
  Nginx from Project 1 was already running on port 80.
  The Docker container couldn't start because the port was taken.
  Fixed by stopping Nginx before starting the container.
  Error message: "bind: address already in use"

Challenge 3 — Docker not available in WSL
  Docker Desktop was installed on Windows but WSL couldn't
  use it. Fixed by enabling WSL integration in Docker Desktop
  settings under Resources.

## What I learned
- Writing a Dockerfile from scratch
- How GitHub Actions pipelines are structured
- What CI/CD actually means in practice — not just theory
- Port mapping between containers and the host machine
- How to read pipeline error logs and debug them
- Real engineers don't deploy manually — everything is automated

## Cost
Pipeline runs on GitHub's free servers — $0
App runs on the EC2 from Project 1 — covered by free tier
