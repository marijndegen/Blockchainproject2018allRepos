package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.dtos.admin.newelection.NewElectionRequest;
import org.han.ica.oose.sneeuwklokje.exceptions.NoPlannedElectionException;
import org.han.ica.oose.sneeuwklokje.exceptions.SmartContractInteractionException;
import org.han.ica.oose.sneeuwklokje.services.admin.AdminService;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("admin")
public class AdminRestController {

    @Inject
    private AdminService adminService;

    /**
     * Returns a list of running elections
     * @return Response
     */
    @Path("elections/open/")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response openAdminPageAndShowRunningElections() {
        return Response.ok().entity(adminService.getRunningElections()).build();
    }

    /**
     * Returns a list of parties used for making a new election
     * @return Response
     */
    @Path("parties/")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPartiesForCreatingNewElections() {
        return Response.ok().entity(adminService.getPartiesForMakingNewElection()).build();
    }

    /**
     * Closes running elections based on electionId
     * @param electionId
     * @return Response
     */
    @Path("elections/close/{id}")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response closeRunningElectionOnAdminPage(@PathParam("id") int electionId) {
        if (electionId != 0) {
            adminService.closeRunningElection(electionId);
            return Response.ok().build();
        } else {
            return Response.status(400).build();
        }
    }

    /**
     * Inserts a new election in the database with the data from request
     * @param request
     * @return Response
     */
    @Path("election/")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response getDataForCreatingNewElection(NewElectionRequest request) {
        if (request.getName() != null) {
            adminService.createNewElection(request.getName(), request.getStartDate(), request.getEndDate(), request.getPartyIds());
            return Response.status(201).build();
        } else {
            return Response.status(500).build();
        }
    }

    /**
     * Returns a list of elections that are not yet published on the blockchain
     * @return
     */
    @Path("election/planned")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPlannedElections() {
        return Response.ok().entity(adminService.getPlannedElections()).build();
    }

    /**
     * Publishes an election with the given electionId
     * @param electionId
     * @return Response
     */
    @Path("election/publish/{id}")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response publishPlannedElection(@PathParam("id") int electionId){
        try {
            adminService.publishElection(electionId);
            return Response.status(201).build();
        } catch (SmartContractInteractionException e) {
            return Response.status(500).build();
        } catch (NoPlannedElectionException e) {
            return Response.status(400).build();
        }
    }
}
