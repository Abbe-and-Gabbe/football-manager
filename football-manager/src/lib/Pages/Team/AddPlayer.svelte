<script>
    export let id;
    let email = "";
    let error

    function handleSubmit() {
        console.log(`Submitting email: ${email}`);

        const f = fetch(`http://localhost:8080/team/${id}/invite`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                email: email,
                teamId: id,
            }),
        });

        f.then((res) => {
            return res.json();
        })
            .then((data) => {
                error = data
                console.log(data);
            })
            .catch((error) => {
                console.error(error);
            });
    }
</script>

<div class="w-full max-w-sm mx-auto">
    {#if error }
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
            <strong class="font-bold">Error!</strong>
            <span class="block sm:inline">{error.errorMessage}</span>
        </div>
    {/if}
    <form on:submit|preventDefault={handleSubmit}>
        <div class="flex items-center border-b border-teal-500 py-2">
            <input
                bind:value={email}
                class="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none dark:text-gray-300"
                type="email"
                placeholder="Enter players email"
            />
            <button
                class="flex-shrink-0 bg-teal-500 hover:bg-teal-700 border-teal-500 hover:border-teal-700 text-sm border-4 text-white py-1 px-2 rounded"
                type="submit"
            >
                Invite player
            </button>
        </div>
    </form>
</div>
