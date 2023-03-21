<script>
    import ClubNavBar from "../clubNavBar.svelte";
    import CardForContactPage from "./CardForContactPage.svelte";
  
    export let id;
    let contactPersons = [];
  
    let fetchContactInfo = fetch(`http://localhost:8080/club/${id}/contact`)
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        console.log(data);
        if (Array.isArray(data.contactPersons)) {
          contactPersons = data.contactPersons;
        }
      })
      .catch((error) => {
        console.error(error);
      });
  </script>
  
  <ClubNavBar id={id} />
  <CardForContactPage contactPersons={contactPersons} />
  