<script>
  import NotifyButton from './NotifyButton.svelte';

  // This will be changed later when the backend is implemented
  let loggedIn = true;
</script>

<div class="text-black dark:text-white p-8 flex">
  {#if loggedIn}
    <div class="flex">
      <img
        src="images/userImg.jpg"
        alt="userImg"
        class="w-7 h-7 rounded-full m-2"
      />
      <NotifyButton/>
    </div>
  {:else}
    <button
      class="rounded bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 "
    >
      Login
    </button>
  {/if}
</div>
