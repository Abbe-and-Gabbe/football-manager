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
      <button
        type="button"
        class="relative inline-flex items-center px-5 py-2.5 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
      >
        <svg
          class="w-5 h-5 mr-1"
          aria-hidden="true"
          fill="currentColor"
          viewBox="0 0 20 20"
          xmlns="http://www.w3.org/2000/svg"
          ><path
            d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"
          /><path
            d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"
          /></svg
        >
        <span class="sr-only">Notifications</span>
        Notifications
        {#if count > 0}        
        <div
          class="absolute inline-flex items-center justify-center w-6 h-6 text-xs font-bold text-white bg-red-500 border-2 border-white rounded-full -top-2 -right-2 dark:border-gray-900"
          class:animate-bounce={count > 0}
        >
          {count}
        </div>
        {/if}
      </button>
    </div>
  {:else}
    <button
      class="rounded bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 "
    >
      Login
    </button>
  {/if}
</div>
