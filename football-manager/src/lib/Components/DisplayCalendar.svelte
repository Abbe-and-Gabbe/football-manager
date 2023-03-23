<script>
  export let games;

  let currentDate = new Date();

  // Months and weekdays
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  // Calculate days in month
  function daysInMonth(month, year) {
    return new Date(year, month + 1, 0).getDate();
  }

  // Calculate week number
  function getWeekNumber(date) {
    const year = date.getFullYear();
    const firstDayOfYear = new Date(year, 0, 1);
    const daysSinceFirstDayOfYear = Math.ceil(
      (date.getTime() - firstDayOfYear.getTime()) / (86400000 * 7)
    );
    const weekNumber = Math.ceil(
      (daysSinceFirstDayOfYear + firstDayOfYear.getDay() + 1) / 7
    );
    return weekNumber;
  }

  function generateDaysInMonth(month, year) {
    const days = [];
    const firstDayOfMonth = new Date(year, month, 1);
    const lastDayOfMonth = new Date(year, month, daysInMonth(month, year));
    const daysBeforeFirstDayOfMonth = (firstDayOfMonth.getDay() + 6) % 7;

    // Add days before first day of month
    for (let i = 0; i < daysBeforeFirstDayOfMonth; i++) {
      days.push(null);
    }

    // Add days in month
    for (let i = 1; i <= daysInMonth(month, year); i++) {
      days.push(new Date(year, month, i));
    }

    // Add days after last day of month
    const daysAfterLastDayOfMonth = (7 - lastDayOfMonth.getDay() - 1) % 7;
    for (let i = 0; i < daysAfterLastDayOfMonth; i++) {
      days.push(null);
    }

    return days;
  }

  // Selected date
  let selectedDate;

  // Generate days for current month
  let daysInCurrentMonth = generateDaysInMonth(
    currentDate.getMonth(),
    currentDate.getFullYear()
  );

  // Handle arrow click for changing month
  function handleArrowClick(direction) {
    currentDate = new Date(
      currentDate.getFullYear(),
      currentDate.getMonth() + direction,
      1
    );
    daysInCurrentMonth = generateDaysInMonth(
      currentDate.getMonth(),
      currentDate.getFullYear()
    );
  }

  // Handle day click to select date
  function handleDayClick(day) {
    selectedDate = day;
  }

</script>

<section class="animate-fade-in flex-col mt-10">
    <div
      class="bg-slate-500 dark:bg-slate-400 static justify-evenly flex-col p-4 md:p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in"
    >
      <h1 class="text-left mb-10 text-3xl">Club Calendar</h1>
  
      <!-- Arrow buttons for changing month -->
      <div class="flex items-center">
        <button
          class="text-white rounded-full bg-gray-400 hover:bg-gray-600 p-2"
          on:click={() => handleArrowClick(-1)}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M15 19l-7-7 7-7"
            />
          </svg>
        </button>
        <div class="flex-grow mx-4 text-2xl text-center">
          {months[currentDate.getMonth()]}
          {currentDate.getFullYear()}
        </div>
        <button
          class="text-white rounded-full bg-gray-400 hover:bg-gray-600 p-2"
          on:click={() => handleArrowClick(1)}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 5l7 7-7 7"
            />
          </svg>
        </button>
      </div>
  
      <!-- Calendar grid -->
      <div class="grid grid-cols-7 gap-2 mt-4">
        {#each weekdays as day}
          <div
            class="bg-slate-400 dark:bg-slate-700 py-2 rounded-xl text-white text-center font-bold"
          >
            {day}
          </div>
        {/each}
        {#each daysInCurrentMonth as day}
          <div
            class="bg-white dark:bg-gray-800 py-2 rounded-xl text-gray-800 dark:text-white text-center font-bold cursor-pointer transition-colors duration-200 hover:bg-gray-200 dark:hover:bg-slate-600">
            {#if day !== null}
              <span class="text-sm">{day.getDate()}</span>
              {#if games}
              {#each games as game }
                  <div class="text-xs">
                   <p>{game.homeTeam} vs {game.awayTeam}</p> 
                   <p>{game.date}</p> 

                  </div>
              {/each}
            {/if}
            {/if}
          </div>
        {/each}
      </div>
    </div>
  </section>
  