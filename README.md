civic-app-petition-prototype
============================

http://attroc.hackupstate.com/

TODO:
- For checking auth we should standardize the checking and force checking for 
  most methods, keeping a whitelist. I remember doing something like this
  via the applications controller previously. Look into it.

- We need to make Resident and Petition unique id's for the signatures table and 
  enforce that on the model. Right now I can sign the petition multiple times via refresh.

- How are we going to handle all the different users? Will they all be able sign 
  petitions? We should go over this and set some reqs before moving on.