<script>
    export let id
    let news

    const f = fetch(`http://localhost:8080/team/${id}/news`)

    f.then((res) => {
        return res.json()
    }).then((data) => {
        news = data
    })

</script>

{id}