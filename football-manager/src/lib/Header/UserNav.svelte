<script>
  import NotifyButton from "./NotifyButton.svelte";

  // This will be changed later when the backend is implemented
  let loggedIn = false;
</script>

<div class="text-black dark:text-white p-8 flex">
  {#if loggedIn}
    <div class="flex">
      <img
        src="images/userImg.jpg"
        alt="userImg"
        class="w-7 h-7 rounded-full m-2"
      />
      <NotifyButton />
    </div>
  {:else}
    <button
      class="relative inline-flex items-center px-5 py-2.5 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
    >
      Login
    </button>
  {/if}
</div>
