package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.dtos.authentication.AuthenticationRequest;
import org.han.ica.oose.sneeuwklokje.exceptions.SmartContractInteractionException;
import org.han.ica.oose.sneeuwklokje.services.election.ElectionService;
import org.han.ica.oose.sneeuwklokje.services.voter.VoterService;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.Level;
import java.util.logging.Logger;

@Path("/authentication")
public class AuthenticationRestController {

    private final Logger LOGGER = Logger.getLogger(getClass().getName());

    @Inject
    private VoterService voterService;

    @Inject
    private ElectionService electionService;

    /**
     * Returns a voting ballot when the authentication passes
     * @param request
     * @return Response
     */
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response authenticate(AuthenticationRequest request) {
        String token = request.getToken();
        int electionId = electionService.getElectionIdBasedOnToken(token);
        if (voterService.doAuthenticationToken(token) && electionService.isElectionBeforeEndDate(electionId)) {
            try {
                return Response.ok().entity(electionService.createBallotResponse(electionId)).build();
            } catch (SmartContractInteractionException e) {
                LOGGER.log(Level.SEVERE, "Can't authenticate user. ", e);
                return Response.status(500).build();
            }
        } else {
            return Response.status(403).build();
        }
    }

}
