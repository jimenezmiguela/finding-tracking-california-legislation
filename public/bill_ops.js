function handle_ajax(event) {
    console.log('DOM fully loaded and parsed');
    const authHeader = localStorage.getItem("authHeader");
    const resultsDiv = document.getElementById('results-div');
    const restOpsDiv = document.getElementById('rest-ops');
  
    //users
    const listusersButton = document.getElementById('list-users');
    const createuserButton = document.getElementById('create-user');
    const firstName = document.getElementById('user-firstName');
    const lastName = document.getElementById('user-lastName');
    const userEmail = document.getElementById('user-email');
    const userPassword = document.getElementById('user-password');
    const userCategory = document.getElementById('user-category');
    const updateuserButton = document.getElementById('update-user');
    const userID = document.getElementById('user-id');
    const firstName1 = document.getElementById('user-firstName1');
    const lastName1 = document.getElementById('user-lastName1');
    const updateEmail = document.getElementById('update-email');
    const updatePassword = document.getElementById('update-password');
    const userUpdateCategory = document.getElementById('user-update-category');
    const userIDToDelete = document.getElementById('user-id-delete')
    const deleteuserButton = document.getElementById('delete-user-button')
    
    //bills
    const listbillsuserID = document.getElementById('list-bills-user-id')
    const listAllbillsButton = document.getElementById('list-all-bills-button')
    const createbillsuserID = document.getElementById('create-bills-user-id')
    const billMeasureToCreate = document.getElementById('bill-measure-to-create')
    const billSubjectToCreate = document.getElementById('bill-subject-to-create')
    const billAuthorToCreate = document.getElementById('bill-author-to-create')
    const billStatusToCreate = document.getElementById('bill-status-to-create')
    const billCategoryToCreate = document.getElementById('bill-category-to-create')
    const billLocalProgramToCreate = document.getElementById('bill-local-program-to-create')
    const createbillsButton = document.getElementById('create-bills-button')
    const billUpdateuserID = document.getElementById('bill-update-user-id')
    const billUpdatebillID = document.getElementById('bill-update-bill-id')
    const billMeasureToUpdate = document.getElementById('bill-measure-to-update')
    const billSubjectToUpdate = document.getElementById('bill-subject-to-update')
    const billAuthorToUpdate = document.getElementById('bill-author-to-update')
    const billStatusToUpdate = document.getElementById('bill-status-to-update')
    const billCategoryToUpdate = document.getElementById('bill-category-to-update')
    const billLocalProgramToUpdate = document.getElementById('bill-local-program-to-update')
    const updatebillsButton = document.getElementById('update-bills-button')
    const deletebilluserID = document.getElementById('delete-bills-user-id')
    const deletebillbillID = document.getElementById('delete-bills-bill-id')
    const deletebillsButton = document.getElementById('delete-bills-button')
  
    var billsCategory = document.getElementById('bills-category')
    const billsButton = document.getElementById('bills-button')
    var billText = document.getElementById('bill-text')
    const billTextButton = document.getElementById('bill-text-button')
   
    const users_path = '/api/v1/users';
    const bills_path = '/api/v1/bills';
    const measures_path = '/api/v1/measures';
    const text_path = '/api/v1/text';
    
      restOpsDiv.addEventListener('click', async (event) => {
        if (event.target === listusersButton) {
          fetch(users_path,
              {  headers: { 'Content-Type': 'application/json',
              'authorization': authHeader } }
            ).then((response) => {
            if (response.status === 200) {
              resultsDiv.innerHTML = '';
              response.json().then((data) => {
                for (let i=0; i<data.length; i++) {
                  let parag = document.createElement('P');
                  parag.textContent = JSON.stringify(data[i]);
                  resultsDiv.appendChild(parag);
                }
              });
            } else {
              alert(`Return code ${response.status} ${response.statusText}`);
            }
          }).catch((error) => {
            console.log(error);
            alert(error);
          });
        } else if (event.target === createuserButton) {
          var dataObject = {
            first_name: firstName.value,
            last_name: lastName.value,
            email: userEmail.value,
            password: userPassword.value,
            category: userCategory.value
          }
          fetch(users_path,
            { method: 'POST',
              headers: { 'Content-Type': 'application/json',
                'authorization': authHeader },
              body: JSON.stringify(dataObject)
            }
          ).then((response) => {
            if (response.status === 201) {
              response.json().then((data) => {
                resultsDiv.innerHTML = '';
                let parag = document.createElement('P');
                parag.textContent = JSON.stringify(data);
                resultsDiv.appendChild(parag);
              });
            } else {
              response.json().then((data) => {
                alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
              }).catch((error) => {
                console.log(error);
                alert(error);
              });
            }
          });
        } else if (event.target === updateuserButton) {
          var dataObject = {
            first_name: firstName1.value,
            last_name: lastName1.value,
            email: updateEmail.value,
            password: updatePassword.value,
            category: userUpdateCategory.value
          }
          fetch(`${users_path}/${userID.value}`,
            { method: 'PUT',
              headers: { 'Content-Type': 'application/json',
                'authorization': authHeader },
              body: JSON.stringify(dataObject)
            }
          ).then((response) => {
            if (response.status === 200) {
              response.json().then((data) => {
                resultsDiv.innerHTML = '';
                let parag = document.createElement('P');
                parag.textContent = JSON.stringify(data);
                resultsDiv.appendChild(parag);
              });
            } else {
              response.json().then((data) => {
                alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
              }).catch((error) => {
                console.log(error);
                alert(error);
              });
            }
          });
        }
  
        // users CRUD - Delete
        else if (event.target === deleteuserButton) {
          fetch(`${users_path}/${userIDToDelete.value}`,
            {
              method: 'DELETE',
              headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem("authHeader")
              },
            }
          ).then((response) => {
            if (response.status === 200) {
              response.json().then((data) => {
                resultsDiv.innerHTML = '';
                let parag = document.createElement('P');
                parag.textContent = JSON.stringify(data);
                resultsDiv.appendChild(parag);
              });
            } else {
              response.json().then((data) => {
                alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
              }).catch((error) => {
                console.log(error);
                alert(error);
              });
            }
          });
        }
  
        // bills CRUD - Create
        else if (event.target === createbillsButton) {
          if (billLocalProgramToCreate.value){
            billLocalProgramToCreate.value === true
          }
        try {
          var dataObject = { measure: billMeasureToCreate.value, subject: billSubjectToCreate.value, 
            author: billAuthorToCreate.value, status: billStatusToCreate.value, category: billCategoryToCreate.value,
            local_program: billLocalProgramToCreate.value }
          const response = await fetch(`${users_path}/${createbillsuserID.value}/bills`,
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'authorization': authHeader
              },
              body: JSON.stringify(dataObject)
            })
          const data = await response.json()
          if (response.status === 201) {
            resultsDiv.innerHTML = ''
            let parag = document.createElement('P')
            parag.textContent = JSON.stringify(data)
            resultsDiv.appendChild(parag);
          } else {
            alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
          }
        } catch (error) {
          console.log(error);
          alert(error);
        }
      }//End bills CRUD - Create
  
        // bills CRUD - Read
        else if (event.target === listAllbillsButton) {
          try {
            const response = await fetch(`${users_path}/${listbillsuserID.value}/bills`,
              {
                method: 'GET',
                headers: {
                  'Content-Type': 'application/json',
                  'authorization': authHeader
                }
              })
            const data = await response.json()
            if (response.status === 200) {
              resultsDiv.innerHTML = ''
              if (data.length === 0) {
                let parag = document.createElement('P')
                parag.textContent = "There are no bills for this user."
                resultsDiv.appendChild(parag)
              } else {
                for (let i = 0; i < data.length; i++) {
                  let parag = document.createElement('P');
                  parag.textContent = JSON.stringify(data[i]);
                  resultsDiv.appendChild(parag);
                }
              }
            } else {
              alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
            }
          } catch (error) {
            console.log(error);
            alert(error);
          }
        }// End bills CRUD - Read
  
      //bills CRUD - Update
      else if (event.target === updatebillsButton) {
        if (billLocalProgramToUpdate.value){
          billLocalProgramToUpdate.value === true
        }
        try {
          var dataObject = { measure: billMeasureToUpdate.value, subject: billSubjectToUpdate.value, 
            author: billAuthorToUpdate.value, status: billStatusToUpdate.value, category: billCategoryToUpdate.value,
            local_program: billLocalProgramToUpdate.value }
          if (!dataObject.bill_text) {
            delete dataObject.bill_text
          }
          if (!(dataObject.likes===0) && !dataObject.likes) {
            delete dataObject.likes
          }
          const response = await fetch(`${users_path}/${billUpdateuserID.value}/bills/${billUpdatebillID.value}`,
            {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json',
                'authorization': authHeader
              },
              body: JSON.stringify(dataObject)
            })
          const data = await response.json()
          if (response.status === 200) {
            resultsDiv.innerHTML = ''
            let parag = document.createElement('P')
            parag.textContent = JSON.stringify(data)
            resultsDiv.appendChild(parag);
          } else {
            alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
          }
        } catch (error) {
          console.log(error);
          alert(error);
        }
      }//End bills CRUD - Update
  
      //bills CRUD - Delete
      else if (event.target === deletebillsButton) {
        try {
          const response = await fetch(`${users_path}/${deletebilluserID.value}/bills/${deletebillbillID.value}`,
            {
              method: 'DELETE',
              headers: {
                'Content-Type': 'application/json',
                'authorization': authHeader
              }
            })
          const data = await response.json()
          if (response.status === 200) {
            resultsDiv.innerHTML = ''
            let parag = document.createElement('P')
            parag.textContent = JSON.stringify(data)
            resultsDiv.appendChild(parag);
          } else {
            alert(`Return code ${response.status} ${response.statusText} ${JSON.stringify(data)}`);
          }
        } catch (error) {
          console.log(error);
          alert(error);
        }
      }//End bills CRUD - Delete
  
      else if (event.target === billsButton) {
        if (billsCategory.value === 'California Constitution') {
          billsCategory.value = "CONS"
        }
        else if (billsCategory.value === 'Business and Professions'){
          billsCategory.value = "BPC"
        }
        else if (billsCategory.value === 'Civil'){
          billsCategory.value = "CIV"
        }
        else if (billsCategory.value === 'Civil Procedure'){
          billsCategory.value = "CCP"
        }
        else if (billsCategory.value === 'Corporations'){
          billsCategory.value = "CORP"
        }
        else if (billsCategory.value === 'Education'){
          billsCategory.value = "EDC"
        }
        else if (billsCategory.value === 'Elections'){
          billsCategory.value = "ELEC"
        }
        else if (billsCategory.value === 'Evidence'){
          billsCategory.value = "EVID"
        }
        else if (billsCategory.value === 'Family'){
          billsCategory.value = "FAM"
        }
        else if (billsCategory.value === 'Financial'){
          billsCategory.value = "FIN"
        }
        else if (billsCategory.value === 'Fish and Game'){
          billsCategory.value = "FGC"
        }
        else if (billsCategory.value === 'Food and Agricultural'){
          billsCategory.value = "FAC"
        }
        else if (billsCategory.value === 'Government'){
          billsCategory.value = "GOV"
        }
        else if (billsCategory.value === 'Harbors and Navigation'){
          billsCategory.value = "HNC"
        }
        else if (billsCategory.value === 'Health and Safety'){
          billsCategory.value = "HSC"
        }
        else if (billsCategory.value === 'Insurance'){
          billsCategory.value = "INS"
        }
        else if (billsCategory.value === 'Labor'){
          billsCategory.value = "LAB"
        }
        else if (billsCategory.value === 'Military and Veterans'){
          billsCategory.value = "MVC"
        }
        else if (billsCategory.value === 'Penal'){
          billsCategory.value = "PEN"
        }
        else if (billsCategory.value === 'Probate'){
          billsCategory.value = "PROB"
        }
        else if (billsCategory.value === 'Public Contract'){
          billsCategory.value = "PCC"
        }
        else if (billsCategory.value === 'Public Resources'){
          billsCategory.value = "PRC"
        }
        else if (billsCategory.value === 'Public Utilities'){
          billsCategory.value = "PUC"
        }
        else if (billsCategory.value === 'Revenue and Taxation'){
          billsCategory.value = "RTC"
        }
        else if (billsCategory.value === 'Streets and Highways'){
          billsCategory.value = "SHC"
        }
        else if (billsCategory.value === 'Unemployment Insurance'){
          billsCategory.value = "UIC"
        }
        else if (billsCategory.value === 'Vehicle'){
          billsCategory.value = "VEH"
        }
        else if (billsCategory.value === 'Water'){
          billsCategory.value = "WAT"
        }
        else if (billsCategory.value === 'Welfare and Institutions'){
          billsCategory.value = "WIC"
        }
        fetch(`${measures_path}${"?session_year=20232024&house=Both&author=All&lawCode="}${billsCategory.value}`,
            {  headers: { 'Content-Type': 'application/json',
            'authorization': authHeader } }
          )
          .then((response) => {
             console.log(response);
          if (response.status === 200) {
            resultsDiv.innerHTML = '';
            response.json().then((data) => {
              for (let i=0; i<data.length; i++) {
                let parag = document.createElement('p');
                parag.textContent = JSON.stringify(data[i]);
                resultsDiv.appendChild(parag);
              }
            });
          } else {
            alert(`Return code ${response.status} ${response.statusText}`);
          }
        }).catch((error) => {
          console.log(error);
          alert(error);
        });
      }
  
      else if (event.target === billTextButton) {
        fetch(`${text_path}${"?bill_id=202320240"}${billText.value}`,
              {
                method: 'GET',
                headers: {
                  'Content-Type': 'application/json',
                  'authorization': authHeader
                }
              })
          .then((response) => {
             console.log(response);
          if (response.status === 200) {
            resultsDiv.innerHTML = '';
            response.json().then((data) => {
              for (let i=0; i<data.length; i++) {
                let parag = document.createElement('p');
                parag.textContent = JSON.stringify(data[i]);
                resultsDiv.appendChild(parag);
              }
            });
          } else {
            alert(`Return code ${response.status} ${response.statusText}`);
          }
        }).catch((error) => {
          console.log(error);
          alert(error);
        });
      }
  
      });
    }
    document.addEventListener('DOMContentLoaded', handle_ajax(event));
  
