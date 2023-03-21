<script>
  export let person;
</script>

<div
    class="bg-slate-200 dark:bg-slate-800 flex justify-between lg:flex-row gap-2 rounded-xl items-center animate-fade-in mb-2 hover:bg-slate-300 dark:hover:bg-slate-700 border border-slate-600 pl-12 ">

    {#if person.role }
        <div class="flex flex-col prose dark:prose-invert">
            <h2>Name: {person.firstName} {person.lastName}</h2>
            <p>Email: {person.email}</p>
            <p>PhoneNumber: {person.phoneNumber}</p>
            <p>Role: {person.role}</p>

        </div>
        <img src={person.image || "https://via.placeholder.com/100"} alt="" class="rounded" />

    {/if}

</div>

