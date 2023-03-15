<script>

  import { user } from "../user-store.js"

  // This will be changed later when the backend is implemented
  let username = ""
  let password = ""
  async function login(){
		
		const response = await fetch("http://localhost:8080/tokens", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded"
			},
			body: `grant_type=password&username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`
		})
		
		// TODO: Need to check status code, etc.
		const body = await response.json()
		
		const accessToken = body.access_token
		
		$user = {
			isLoggedIn: true,
			accessToken,
		}
		
	}
</script>

<form on:submit|preventDefault={login}>
	
	<div>
		Username:
		<input type="text" bind:value={username}>
	</div>
	
	<div>
		Password:
		<input type="password" bind:value={password}>
	</div>
	
	<input type="submit" value="Login">
	
</form>
