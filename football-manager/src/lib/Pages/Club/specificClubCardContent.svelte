<script>
  export let id
  export let newsId
  let specificNews
  const sn = fetch(`http://localhost:8080/club/${id}/news/${newsId}`);
  sn.then((res) => {
    return res.json();
  }).then((data) => {
    data.forEach((item) => {
      item.published = item.published.slice(0, 10);
    });
    specificNews = data;
    console.log(specificNews)
  });
</script>

<section>
  <h1>TRY</h1>
    {#if specificNews}
    {#each specificNews as item (item.newsId) }
    <div>TOTOTOTOTOTO: {item.title}</div>
    <div>{item.content}</div>
        
    {/each}
        
    {/if}
</section>

