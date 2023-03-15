<script>
  export let id
  export let newsId
  let specificNews
  const sn = fetch(`http://localhost:8080/team/${id}/news/${newsId}`);
  sn.then((res) => {
    return res.json();
  }).then((data) => {
    data.forEach((item) => {
      item.published = item.published.slice(0, 10);
    });
    specificNews = data;
  });
</script>

<section>
    {#if specificNews}
    {#each specificNews as item (item.newsId) }
    <div>{item.title}</div>
    <div>{item.content}</div>
        
    {/each}
        
    {/if}
</section>

