<script>
  import {user} from "../user-store"
  import {link} from "svelte-routing";
  // This will be changed later when the backend is implemented
  let username = "";
  let password = "";

  console.log($user);


</script>

<div class="flex gap-2 prose dark:prose-invert">
  {#if $user.JWT}
    <div>
      <p>{$user.firstName} {$user.lastName}</p>
    </div>
    <div>
      <p>Logout</p>
    </div>
  {:else}
    <div>
      <a href="/login" use:link>Login</a>
    </div>
    <div>
      <a href="/register" use:link>Register</a>
    </div>
  {/if}
</div>
