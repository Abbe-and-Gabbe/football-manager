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
  import Team from "./lib/Pages/Team/Team.svelte";
  import Squad from "./lib/Pages/Team/Squad.svelte";
  import Calendar from "./lib/Components/Calendar.svelte";
  import ClubCalendar from "./lib/Pages/Club/ClubCalendar/ClubCalendar.svelte";
    import TeamCalendar from "./lib/Pages/Team/TeamCalendar.svelte";
    import News from "./lib/Pages/News/News.svelte";
    import Person from "./lib/Pages/Person/Person.svelte";
  export let url = "";
</script>

<Router {url}>
  <Navbar />
  <main
    class="dark:bg-slate-900 bg-slate-100 dark:text-white p-12 shadow-xl h-full"
  >
    <Route path="/" component={Home} />
    <Route path="/club/:id" let:params>
      <Club id={params.id} />
    </Route>

    <Route path="/club/:id/calendar" let:params>
      <ClubCalendar id={params.id} />
    </Route>

    <Route path="/team/:id" let:params>
      <Team id={params.id} />
    </Route>

    <Route path="/club/:id/teams" let:params>
      <Teams id={params.id} />
    </Route>

    <Route path="/club/:id/contact" let:params>
      <ContactPage id={params.id} />
    </Route>

    <Route path="/team/:id" let:params>
      <Team id={params.id} />
    </Route>

    <Route path="/team/:id/squad" let:params>
      <Squad id={params.id} />
    </Route>

    <Route path="/team/:id/calendar" let:params>
      <TeamCalendar id={params.id} />
    </Route>

    <Route path="/news/:id" let:params>
      <News id={params.id} />
    </Route>

    <Route path="/person/:id" let:params>
      <Person id={params.id} />
    </Route>
  </main>
</Router>
<Footer />
