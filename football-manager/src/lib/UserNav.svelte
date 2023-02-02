<script>
  let loggedIn = true;
</script>

<div class="text-black dark:text-white p-8 flex justify-between">
  {#if loggedIn}
      <img src="images/userImg.jpg" alt="userImg" class="w-10 h-10 rounded-full m-2" />
      <img src="images/bell.png" alt="userImg" class="w-10 h-10 rounded-full m-2 dark:invert" />
  {:else}
    <button
      class="rounded bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 "
    >
      Login
    </button>
  {/if}
</div>
