"""

ConqueSubprocess

Create and interact with a subprocess through a pty.

Usage:

    p = ConqueSubprocess()
    p.open('bash', {'TERM':'vt100'})
    output = p.read()
    p.write('cd ~/vim' + "\r")
    p.write('ls -lha' + "\r")
    output += p.read(timeout = 500)
    p.close()

"""

if CONQUE_PLATFORM == 'nix':
    import os, signal, pty, tty, select, fcntl, termios, struct

class ConqueSubprocess:

    # process id
    pid = 0
    
    # stdout+stderr file descriptor
    fd = None

    # constructor
    def __init__(self): # {{{
        self.pid = 0
        # }}}

    # create pty + subprocess
    def open(self, command, env = {}): # {{{

        # parse command
        command_arr  = command.split()
        executable   = command_arr[0]
        args         = command_arr

        # try to fork a new pty
        try:
            self.pid, self.fd = pty.fork()
            logging.debug(self.pid)
        except:
            logging.debug("pty.fork() failed. Did you mean pty.spork() ???")
            return False

        # child proc, replace with command after altering terminal attributes
        if self.pid == 0:

            # set requested environment variables
            for k in env.keys():
                os.environ[k] = env[k]

            # set some attributes
            try:
                attrs = tty.tcgetattr(1)
                attrs[0] = attrs[0] ^ tty.IGNBRK
                attrs[0] = attrs[0] | tty.BRKINT | tty.IXANY | tty.IMAXBEL
                attrs[2] = attrs[2] | tty.HUPCL
                attrs[3] = attrs[3] | tty.ICANON | tty.ECHO | tty.ISIG | tty.ECHOKE
                attrs[6][tty.VMIN]  = 1
                attrs[6][tty.VTIME] = 0
                tty.tcsetattr(1, tty.TCSANOW, attrs)
            except:
                logging.debug('attribute setting failed')
                pass

            # replace this process with the subprocess
            os.execvp(executable, args)

        # else master, do nothing
        else:
            pass

        # }}}

    # read from pty
    # XXX - select.poll() doesn't work in OS X!!!!!!!
    def read(self, timeout = 1): # {{{

        output = ''
        read_timeout = float(timeout) / 1000

        try:
            # read from fd until no more output
            while 1:
                s_read, s_write, s_error = select.select( [ self.fd ], [], [], read_timeout)

                lines = ''
                for s_fd in s_read:
                    try:
                        lines = os.read( self.fd, 32 )
                    except:
                        pass
                    output = output + lines.decode('utf-8')

                if lines == '':
                    break
        except:
            pass

        return output
        # }}}

    # I guess this one's not bad
    def write(self, input): # {{{
        try:
            if CONQUE_PYTHON_VERSION == 2:
                os.write(self.fd, input)
            else:
                os.write(self.fd, bytes(input, 'utf-8'))
        except:
            logging.debug('write fail')
            pass
        # }}}

    # signal process
    def signal(self, signum): # {{{
        try:
            os.kill(self.pid, signum)
        except:
            pass
        # }}}

    # close process
    def close(self): # {{{
        self.signal(15)
        # }}}

    # get process status
    def is_alive(self): #{{{

        p_status = True

        try:
            if os.waitpid( self.pid, os.WNOHANG )[0]:
                p_status = False
        except:
            p_status = False

        return p_status

        # }}}

    # update window size in kernel, then send SIGWINCH to fg process
    def window_resize(self, lines, columns): # {{{
        try:
            fcntl.ioctl(self.fd, termios.TIOCSWINSZ, struct.pack("HHHH", lines, columns, 0, 0))
            os.kill(self.pid, signal.SIGWINCH)
        except:
            pass

        # }}}


