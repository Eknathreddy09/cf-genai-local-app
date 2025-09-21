### Llama 3.2 Chatbot on Tanzu Platform for Cloud Foundry

This is a Python Flask chatbot application that integrates the Llama 3.2:1b LLM using Ollama, deployed as a single app on Cloud Foundry. The app runs both the LLM model and chatbot interface inside the same Cloud Foundry container.

Features: 

- Python Flask web app with a simple chatbot UI
- Integrates Llama 3.2 model via Ollama local server
- Automatically installs and starts Ollama and the Llama 3.2 model on app push
- All-in-one container deployment on Cloud Foundry (no external services)
- Easy prompt and response interaction with the LLaMA 3.2 model

##### Deployment Instructions: 

- Clone this repository.
- Make sure you have the Cloud Foundry CLI installed and logged in.
- Verify the 'manifest.yaml' memory, disk quota, and timeout settings suit your environment.
- Push the app to Cloud Foundry:

```
cf push your-app-name
```
