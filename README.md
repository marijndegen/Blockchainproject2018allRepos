### How to install these artifacts

#### backend

The backend is a tommee project, the package manager used is maven, the test framework is junit in combination with the mocking service mockito. 



**Install instructions**

Install tommee (can run on tomcat with xampp), make a war of the artifact and it should run under tomcat. Before you can make the artifact you need to install all the dependancies with `mvn install`, don't forget to add maven to your path so you can execute the mvn command.

#### frontend

`npm i` in the frontend map, make sure you got node and npm, troubleshoot every bug that keeps you from running the artifact with the `npm start ` or the `ng serve ` command.

#### Ethereum (with solidity)

You need a blockchain, fastest option is to use rickeby https://www.rinkeby.io/#stats and to create a wallet with a https://web3j.io/ commandline tool. Save the credentials to an ethereum wallet file (backend\src\main\resources\configuration.properties)

#### database

Do you think you got everthing setup?! Nice, hope it wasn't that much of a strugle.. The database that keeps track of the voter ballots etc., just use the insert script and everything should speak for itself.