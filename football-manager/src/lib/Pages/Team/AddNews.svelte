<script>
    let title = "";
    let content = "";
    export let id;

    function handleSubmit() {
        console.log(`Submitting article: title=${title}, content=${content}`);

        const data = {
            title,
            content,
        };

        const f = fetch(`http://localhost:8080/team/${id}/add-news`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                title: title,
                content: content,
            }
            ),
        });
        f.then((res) => {
            return res.json();
        })
            .then((data) => {
                // Go to /team/{id}
                window.location.href = `/team/${id}`;
                console.log(data);
            })
            .catch((error) => {
                console.error(error);
            });
    }
</script>

<div class="w-full max-w-md mx-auto">
    <form on:submit|preventDefault={handleSubmit}>
        <div class="mb-4">
            <label
                class="block text-gray-700 font-bold mb-2 dark:text-white"
                for="title"
            >
                Title
            </label>
            <input
                bind:value={title}
                class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                id="title"
                type="text"
                placeholder="Enter a title"
            />
        </div>
        <div class="mb-6">
            <label
                class="block text-gray-700 font-bold mb-2 dark:text-white"
                for="content"
            >
                Content
            </label>
            <textarea
                bind:value={content}
                class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                id="content"
                placeholder="Enter the article content"
            />
        </div>
        <div class="flex items-center justify-center">
            <button
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                type="submit"
            >
                Create Article
            </button>
        </div>
    </form>
</div>
