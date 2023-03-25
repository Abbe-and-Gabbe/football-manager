<script>
  import Card from "../Components/Card.svelte";
</script>

<!-- This is far from styled correctly, don't even bother to comment this... -->

<section class="animate-fade-in flex-col">
  <div
    class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in"
  >
    <div
      class="prose dark:prose-invert p-12 border border-slate-600 rounded-xl bg-slate-300 dark:bg-slate-800 flex-row w-full text-center"
    >
      <h1>Welcome!</h1>

      <p>
        Welcome to <strong>Football manager</strong>
      </p>
    </div>
  </div>

  <hr
    class="h-px my-8 border border-slate-200 dark:border-slate-700 rounded-xl"
  />

  <div
    class="bg-slate-400 dark:bg-slate-800 p-12 rounded-xl shadow-2xl lg:mx-44"
  >
    <div class="prose dark:prose-invert w-full m-auto text-center mb-12">
      <h2>Features</h2>
    </div>

    <div class="w-full m-auto flex">
      <div class="grid lg:grid-flow-col auto-rows-max m-auto gap-2">
        <Card
          cardTitle="Team management"
          cardDescription="Manage your team, keep track of your players and staff"
        />
        <Card
          cardTitle="Statistics"
          cardDescription="Gather all your statistics at one place, such as goals and assists"
        />
        <Card
          cardTitle="Players"
          cardDescription="Follow the greatest upcoming players"
        />
      </div>
    </div>
  </div>
</section>
