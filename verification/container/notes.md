## container image

For ci purposes, we have gitlab CI setup. to run that on your own end, you'll need to host runner, and get copy of the container. we are using verilator container with entry point removed. (and created that as u_verilator custom containter.)

dockerfile is following:

<code>
FROM verilator/verilator:latest
ENTRYPOINT [ "" ]
</code>

you can either use podman or docker to build it