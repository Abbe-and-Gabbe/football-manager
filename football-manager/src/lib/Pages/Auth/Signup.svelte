<script>
    import {navigate} from 'svelte-routing';
  let firstName = '';
  let lastName = '';
  let email = '';
  let password = '';

  let firstNameError = '';
  let lastNameError = '';
  let emailError = '';
  let passwordError = '';

  const validateFirstName = () => {
    if (!firstName) {
      firstNameError = 'First name is required';
    } else {
      firstNameError = '';
    }
  };

  const validateLastName = () => {
    if (!lastName) {
      lastNameError = 'Last name is required';
    } else {
      lastNameError = '';
    }
  };

  const validateEmail = () => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email) {
      emailError = 'Email is required';
    } else if (!emailRegex.test(email)) {
      emailError = 'Please enter a valid email address';
    } else {
      emailError = '';
    }
  };

  const validatePassword = () => {
    if (!password) {
      passwordError = 'Password is required';
    } else if (password.length < 8) {
      passwordError = 'Password must be at least 8 characters long';
    } else {
      passwordError = '';
    }
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    validateFirstName();
    validateLastName();
    validateEmail();
    validatePassword();
    if (!firstNameError && !lastNameError && !emailError && !passwordError) {
        const f = fetch(`http://localhost:8080/auth/signup?email=${email}&firstName=${firstName}&lastName=${lastName}&password=${password}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                firstName,
                lastName,
                email,
                password
            })
        })
        f.then(res => res.json())
        .then(res => {
            console.log(res)
            navigate('/login')
        })
        .catch(err => {
            console.log(err)
        })

      console.log('Form submitted');
    }
  };
</script>

<form on:submit={handleSubmit} class="max-w-lg mx-auto mt-6">
  <div class="mb-4">
    <label for="firstName" class="block text-gray-700 font-bold mb-2">First Name:</label>
    <input type="text" id="firstName" name="firstName" class="form-input dark:text-black" bind:value={firstName} on:input={validateFirstName}>
    {#if firstNameError}
      <p class="text-red-500 text-sm mt-1">{firstNameError}</p>
    {/if}
  </div>
  <div class="mb-4">
    <label for="lastName" class="block text-gray-700 font-bold mb-2">Last Name:</label>
    <input type="text" id="lastName" name="lastName" class="form-input dark:text-black" bind:value={lastName} on:input={validateLastName}>
    {#if lastNameError}
      <p class="text-red-500 text-sm mt-1">{lastNameError}</p>
    {/if}
  </div>
  <div class="mb-4">
    <label for="email" class="block text-gray-700 font-bold mb-2">Email:</label>
    <input type="email" id="email" name="email" class="form-input dark:text-black" bind:value={email} on:input={validateEmail}>
    {#if emailError}
      <p class="text-red-500 text-sm mt-1">{emailError}</p>
    {/if}
  </div>
  <div class="mb-4">
    <label for="password" class="block text-gray-700 font-bold mb-2">Password:</label>
    <input type="password" id="password" name="password" class="form-input dark:text-black" bind:value={password} on:input={validatePassword}>
    {#if passwordError}
      <p class="text-red-500 text-sm mt-1">{passwordError}</p>
    {/if}
    </div>
    <!-- sumbit btn -->
    <div class="flex justify-center">
      <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Sign Up
      </button>
    </div>
</form>