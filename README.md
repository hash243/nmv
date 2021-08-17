* Navigate to ⚙ Settings -> Secrets -> New repository secret in Github
* On the Name field enter **NGROK_AUTH_TOKEN**
* On the Value field enter the Authtoken you get from https://dashboard.ngrok.com/auth/your-authtoken
* Click Add secret
* Then navigate to Action -> nmv -> Run workflow
* Refresh the page and click nmv -> build
* The URL for login and credential should display at the one before the last dropdown.