package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.services.result.ResultService;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("elections/result")
public class ResultRestController {

    @Inject
    private ResultService resultService;

    /**
     * Returns a list of closed elections
     * @return Response
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getListOfClosedElections() {
        return Response.ok().entity(resultService.closedElectionResponse()).build();
    }

    /**
     * Returns the results of the election with the given electionId
     * @param electionId
     * @return
     */
    @Path("{id}")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response getElectionResult(@PathParam("id") int electionId){
        if(resultService.isElectionClosed(electionId)){
            return Response.ok().entity(resultService.resultElectionResponse(electionId)).build();
        }else{
            return Response.status(400).build();
        }
    }
}
