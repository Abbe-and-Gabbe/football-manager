<script>
  import svelteLogo from "./assets/svelte.svg";
  import Counter from "./lib/Counter.svelte";
  import Footer from "./lib/Footer.svelte";
  import Navbar from "./lib/Header/Navbar.svelte";
  import { Router, Link, Route } from "svelte-routing";
  import Home from "./lib/Pages/Home.svelte";

  export let url = "";
</script>

<Router {url}>
  <Navbar />
  <main
    class="dark:bg-slate-800 bg-slate-100 dark:text-white p-12 shadow-xl"
  >
  <Route path="/" component={Home} />
  </main>
</Router>
<Footer />
