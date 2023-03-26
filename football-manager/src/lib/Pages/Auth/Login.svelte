<script>
  let email = '';
  let password = '';

  import {user} from "../../user-store";
  import { navigate} from 'svelte-routing';


  function handleSubmit() {
    console.log(`Logging in with email=${email} and password=${password}`);

    const f = fetch(`http://localhost:8080/auth/login?email=${email}&password=${password}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      },
    });
    f.then((res) => {
        return res.json();
    }).then((data) => {
      console.log(data);
      $user = {
        id: data.id,
        firstName: data.firstName,
        lastName: data.lastName,
        JWT: data.JWT
      }

      // Redircet to home page without losing the user writable
        navigate('/', {replace: true});

      console.log($user);
    }).catch((err) => {
      console.log(err);
    });
  }
</script>

<div class="w-full max-w-md mx-auto">
  <form on:submit|preventDefault={handleSubmit}>
    <div class="mb-4">
      <label class="block text-gray-700 font-bold mb-2 dark:text-white" for="email">
        Email
      </label>
      <input bind:value={email} class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Enter your email">
    </div>
    <div class="mb-6">
      <label class="block text-gray-700 font-bold mb-2 dark:text-white" for="password">
        Password
      </label>
      <input bind:value={password} class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="Enter your password">
    </div>
    <div class="flex items-center justify-between">
      <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="submit">
        Sign In
      </button>
      <a class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800" href="#">
        Forgot Password?
      </a>
    </div>
  </form>
</div>
