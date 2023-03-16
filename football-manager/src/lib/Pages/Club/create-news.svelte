<script>

    export let id
    export let newsId
    let title = ""
	let content = ""
	let errorCodes = []
	let newsWasCreated = false
	
    async function createNews(){
		
        const news = {
            title,
            content,
            id,
            newsId
        }
            
        try {
            const response = await fetch(`http://localhost:8080/club/${id}/news`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(news),
            })
            
            switch(response.status){
                case 201:
                    newsWasCreated = true
                    break
                case 400:
                    errorCodes = await response.json()
                    break;
                // TODO: Handle 401.
                default:
                    errorCodes.push("UNKNOWN_ERROR")
                    break
            }
            
        } catch(error) {
            errorCodes.push("COMMUNICATION_ERROR")
        }
        
    }
</script>



<div class="h-screen flex items-center justify-center bg-gray-900">
    <form class="w-96 h-128 bg-gray-700 border-2 border-black rounded-lg p-8" on:submit|preventDefault={createNews}>
      <div class="text-center">
        <h3 class="text-white">Create News</h3>
      </div>
      <br>
      <div class="mb-4">
        <input class="w-full bg-gray-800 border border-gray-600 rounded-lg py-2 px-4 text-black" type="text" name="title" bind:value={title} placeholder="Enter Your Title Here!">
      </div>
      <div class="mb-4">
        <input class="w-full bg-gray-800 border border-gray-600 rounded-lg py-2 px-4 text-black" type="text" name="message" bind:value={content} placeholder="Enter Your Message Here!">
      </div>
      <div class="mb-4">
        <button class="w-full bg-blue-800 text-white py-2 px-4 rounded-lg uppercase" type="submit">Create News</button>
      </div>
    </form>
  </div>
  