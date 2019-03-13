package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.dtos.voter.VoterRequest;
import org.han.ica.oose.sneeuwklokje.exceptions.SmartContractInteractionException;
import org.han.ica.oose.sneeuwklokje.services.voter.VoterService;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.Level;
import java.util.logging.Logger;

@Path("/vote")
public class VoterRestController {

    private final Logger LOGGER = Logger.getLogger(getClass().getName());

    @Inject
    private VoterService voterService;

    /**
     * Pushes a vote to the blockchain
     * @param request
     * @return Response
     */
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response vote(VoterRequest request) {

        String token = request.getToken();

        if(!voterService.doAuthenticationToken(token)) {
            return Response.status(400).build();
        }

        int electionId = voterService.getElectionIdBasedOnToken(token);

        if(electionId == 0){
            return Response.status(400).build();
        }

        try {
            if(voterService.pushVoteToBlockchain(token, request.getId(), electionId)){
                return Response.ok().build();
            } else {
                return Response.status(503).build();
            }
        } catch (SmartContractInteractionException e) {
            LOGGER.log(Level.SEVERE, "Can't push vote to the blockchain. ", e);
            return Response.status(500).build();
        }
    }
}

