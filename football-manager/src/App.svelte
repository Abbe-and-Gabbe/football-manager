<script>
  import svelteLogo from "./assets/svelte.svg";
  import Counter from "./lib/Counter.svelte";
  import Footer from "./lib/Footer.svelte";
  import Navbar from "./lib/Header/Navbar.svelte";
</script>

<Navbar />
<main class="dark:bg-slate-800 bg-slate-100 dark:text-white p-12 h-auto shadow-xl">
  <!-- Fill this with content -->
  <section class="prose dark:prose-invert my-2 bg-slate-600 rounded-xl p-2 w-full">
    <h1>
      Welcome to Football manager
    </h1>
  </section>
  <section class="prose dark:prose-invert">
    <Counter />
  </section>
</main>
<Footer/>