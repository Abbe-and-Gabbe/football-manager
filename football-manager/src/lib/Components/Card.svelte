<script>
  export let cardTitle;
  export let cardDescription;
</script>

<div
  class="prose dark:prose-invert bg-slate-300 dark:bg-slate-700 flex-row w-full text-center p-12 border border-slate-600 rounded-xl hover:dark:bg-slate-600 hover:bg-slate-400 hover:dark:border-blue-500"
>
  <h3>
    {cardTitle}
  </h3>
  <p>
    {cardDescription}
  </p>
</div>
