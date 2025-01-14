/***
* This pseudocode helps to understand when and how to use external tools
*/

/* Prepare new Hop */
srvstr = fn(Random select next hop target from args.server:args.port)

//call hook tools
if ! hookpath.is_empty() {
    if hookip.is_empty() {
        /* exec hookpath startpre STREAMID SRVSTR */
        Command::new(hookpath).args(args).spawn().unwrap().wait().unwrap();
    } else {
        relaystr=fn(Random select listen target from args.hookip:args.hookports)
        /* exec hookpath startpre STREAMID SRVSTR RELAYSTR */
        Command::new(hookpath).args(args).spawn().unwrap().wait().unwrap();
        /* replace SRVSTR with RELAYSTR */
        srvstr = relaystr
    }
}

/* Send UDP packager to this new Hop */
mysocket.send_to(buf, srvstr)

/* Do CleanUp this(new) Hop */
if ! hookpath.is_empty() {
    /* exec hookpath stoppost STREAMID */
    Command::new(hookpath).args(args).spawn().unwrap().wait().unwrap();
}
