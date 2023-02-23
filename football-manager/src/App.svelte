<script>
  import svelteLogo from "./assets/svelte.svg";
  import Counter from "./lib/Counter.svelte";
  import Footer from "./lib/Footer.svelte";
  import Navbar from "./lib/Header/Navbar.svelte";
  import { Router, Link, Route } from "svelte-routing";
  import Home from "./lib/Pages/Home.svelte";
  import Club from "./lib/Pages/Club/Club.svelte";
  import Teams from "./lib/Pages/Club/DisplayTeams/Teams.svelte";
  import ContactPage from "./lib/Pages/Club/ContactClubAdmin/ContactPage.svelte";
  export let url = "";
</script>

<Router {url}>
  <Navbar />
  <main
    class="dark:bg-slate-900 bg-slate-100 dark:text-white p-12 shadow-xl h-full"
  >
  <Route path="/" component={Home} />
  <Route path="/club/:id" let:params>
    <Club id="{params.id}" />
  </Route>
  <Route path="/club/:id/teams" let:params> 
    <Teams id="{params.id}"/>

  <Route path="/club/:id/contact" let:params> 
    <ContactPage id="{params.id}"/>

  </Route>
  </main>
</Router>
<Footer />