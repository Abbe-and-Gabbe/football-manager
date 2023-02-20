<script>
     import contactPersons from "../../../assets/contactPersonsData";
</script>

<section class="animate-fade-in flex-col mt-10">
    <div class="bg-slate-500 dark:bg-slate-800 static justify-evenly flex-col p-4 md:p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
      <h1 class="text-left mb-10 text-3xl">Contact Page</h1>
  
      <div class="min-h-fit bg-gray-100 leading-6 py-20">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 p-5 max-w-screen-lg mx-auto">
          {#each contactPersons as person}
          <div class="relative shadow-md rounded-md border-8 border-black text-center bg-gray-800 p-4 md:p-8">
            <div class="h-28 md:h-56 mx-auto md:rounded-full overflow-hidden relative border-8 border-black">
              <img src={person.urlImage} alt="" class="object-cover w-full h-full">
              <div class="overlay absolute top-0 left-0 h-full w-full hover:bg-gray-800 active:bg-gray-700 focus:outline-none focus:ring focus:ring-gray-300 ">
                <ul class="opacity-0 hover:opacity-100 mx-1 my-3  text-white text-sm capitalize transition-opacity transition-margin absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
                  <li>{person.phoneNumber}</li>
                  <li>{person.email}</li>
                </ul>
              </div>
            </div>
            <h3 class="text-lg font-medium text-white capitalize mt-4 md:mt-6">{person.name}</h3>
            <p class="text-white text-base capitalize">{person.role}</p>
          </div>
          {/each}
        </div>
      </div>
    </div>
  </section>