<script>
  import svelteLogo from "./assets/svelte.svg";
  import Counter from "./lib/Counter.svelte";
  import Footer from "./lib/Footer.svelte";
  import Navbar from "./lib/Header/Navbar.svelte";
  import { Router, Link, Route } from "svelte-routing";

  export let url = "";
</script>

<Router {url}>
  <Navbar />
  <main
    class="dark:bg-slate-800 bg-slate-100 dark:text-white p-12 shadow-xl prose"
  >
    <h1>Hello!</h1>
  </main>
</Router>
<Footer />
<div class="p-8 border my-10 mx-auto shadow-md max-w-2xl bg-white rounded-lg">
  <div class="prose">
    <h1>Hello world!</h1>
  </div>
</div>
