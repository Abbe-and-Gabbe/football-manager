<script>
  let email = "";
  let password = "";
  let isLoading = false;
  let isSuccess = false;
  export let submit;
  let errors = {};
  const handleSubmit = () => {
    errors = {};
    if (email.length === 0) {
      errors.email = "Field should not be empty";
    }
    if (password.length === 0) {
      errors.password = "Field should not be empty";
    }
    if (Object.keys(errors).length === 0) {
      isLoading = true;
      submit({ email, password })
        .then(() => {
          isSuccess = true;
          isLoading = false;
        })
        .catch((err) => {
          errors.server = err;
          isLoading = false;
        });
    }
  };
</script>

<div class="flex justify-center">
  <form
    class="bg-gray-100 p-10 w-1/3 rounded-lg flex flex-col items-center justify-center"
  >
    {#if isSuccess}
      <div class="text-black text-center">
        🔓
        <br />
        You've been successfully logged in.
      </div>
    {:else}
      <h1 class="text-4xl font-bold mb-6 text-black">👤</h1>
      <label class="text-black font-bold mb-2 self-start">Email</label>
      <input
        class="w-full text-black border-b-2 border-gray-400 mb-6 px-3 py-2 transition duration-300 ease-in-out focus:outline-none focus:border-gray-600"
        name="email"
        placeholder="name@example.com"
        bind:value={email}
      />

      <label class="text-black font-bold mb-2 self-start">Password</label>
      <input
        class="w-full text-black border-b-2 border-gray-400 mb-6 px-3 py-2 transition duration-300 ease-in-out focus:outline-none focus:border-gray-600"
        name="password"
        type="password"
        placeholder="********"
        bind:value={password}
      />

      <div class="mt-6 flex items-center justify-between w-full">
        <button
          type="submit"
          class="bg-black text-white py-2 px-8 rounded-full text-lg font-bold transition duration-300 ease-in-out hover:-translate-y-1 shadow-lg"
        >
          {#if isLoading}Logging in...{:else}Log in 🔒{/if}
        </button>

        {#if Object.keys(errors).length > 0}
          <ul class="errors">
            {#each Object.keys(errors) as field}
              <li>{field}: {errors[field]}</li>
            {/each}
          </ul>
        {/if}
        <button
          class="bg-gray-300 text-black py-2 px-8 rounded-full text-lg font-bold transition duration-300 ease-in-out hover:-translate-y-1 shadow-lg"
        >
          Register
        </button>
        <button
          class="bg-red-600 text-white py-2 px-8 rounded-full text-lg font-bold transition duration-300 ease-in-out hover:-translate-y-1 shadow-lg"
        >
          Google Login
        </button>
      </div>
    {/if}
  </form>
</div>
