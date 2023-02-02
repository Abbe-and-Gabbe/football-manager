<script>
  // This will be changed later when the backend is implemented
  let loggedIn = true;
  let notifications = ["test", "test2"];
  let count = notifications.length;

  function popNotification() {
    notifications.pop();
    count = notifications.length;
  }
</script>

<div class="text-black dark:text-white p-8 flex">
  {#if loggedIn}
    <div class="flex">
      <img
        src="images/userImg.jpg"
        alt="userImg"
        class="w-7 h-7 rounded-full m-2"
      />
      <!-- svelte-ignore a11y-click-events-have-key-events -->
      <img
        src="images/bell.png"
        alt="userImg"
        class="w-7 h-7 rounded-full dark:invert m-2"
        class:animate-bounce={count > 0}
        on:click={() => {
          popNotification();
        }}
      />
    </div>
  {:else}
    <button
      class="rounded bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 "
    >
      Login
    </button>
  {/if}
</div>
