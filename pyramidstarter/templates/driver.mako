<div class="card">
            <div class="card-header">
                 <h1 class="card-title">DRIVeR</h1>
                <h4 class="card-subtitle mb-2 text-muted">(Acronymn means?)</h4>
            </div>
            <div class="card-body">
                <div id="diver_intro">
                     <h3>Description</h3>
                    <p>Given a library of <i>L</i> sequences generated by random recombination
                        of two near-identical genes differing at only a small number of known nucleotide
                        (or amino acid) positions, we wish to calculate the expected number of
                        distinct sequences in the library. (Typically assuming the mean number
                        of crossovers per sequence <i>m</i> &lt; 0.1 &#xD7; sequence length <i>N</i>).</p>
                     <h3>Example (<a data-toggle="collapse" href="#driver_example"><i class="fas fa-caret-down" aria-hidden="true"></i> show</a>)

                    </h3>
                    <div class="collapse" id="driver_example">
                        <p><a href="https://www.ncbi.nlm.nih.gov/pubmed/11564557" target="_blank">&gt;Raillard et al (2001,

                            <i>Chem.

                                Biol.</i>, <b>8</b>, 891-898) <i class="fas fa-external-link" aria-hidden="true"></i></a>
used
                            DNA shuffling to recombine two bacterial triazine hydrolase genes (<i>atzA</i> and <i>triA</i>,
                            GenBank accession numbers U55933 and AF312304, respectively). The <i>N</i> =
                            1425 nt genes differ at nine nucleotide positions: 250, 274, 375, 650,
                            655, 757, 763, 982 and 991. They screened a library of <i>L</i> = 1600 shuffled
                            variants. They state that &apos;every variant sequenced had undergone at
                            least one and as many as four recombination events&apos;. Thus we estimate
                            that the mean number of observable crossovers per daughter sequence is
                            around <i>m</i>
= 2. The underlying true number of crossovers per daughter
                            sequence is unknown (click <a data-toggle="collapse" href="#driver_discussion">here</a> for
                            discussion).</p>
                        <div class="collapse well" id="driver_discussion">
                            <p>Note that, experimentally, crossovers are only observable if they occur
                                in a region that will produce a distinct daughter sequence. One crossover
                                between a consecutive pair of variable positions will produce the same
                                daughter sequence as 3, 5, 7, ... crossovers. Similarly 2, 4, 6, ... crossovers
                                produce the same daughter sequence as no crossovers at all. In addition,
                                any crossovers occurring between one end of the sequence and the first
                                variable position are also unable to be detected by analysis of the daughter
                                sequence.</p>
                            <p>Typically you will find the mean number of observable crossovers by sequence
                                analysis of a sample of daughter sequences. Nonetheless, the underlying
                                true number of crossovers is also an important statistic to know - especially
                                when you want to try and vary the crossover rate by making adjustments
                                to your recombination protocol.</p>
                            <p>In DRIVeR, you can choose to enter either the mean number of observable
                                crossovers or the true mean number of all crossovers. Either way, DRIVeR
                                will also calculate and tell you the other statistic.</p>
                            <p>Note also the following:
                                <br>The maximum observable crossover rate is (M-1)/2, where M is the number
                                of variable positions. If the true crossover rate is very high, then the
                                variable positions will be essentially randomly assigned in each daughter
                                sequence, and all possible daughters will be essentially equally likely
                                (in fact you can use GLUE instead of DRIVeR).</p>
                            <p>Since we assume that crossovers cannot occur immediately following a variable
                                position (due to the nature of the reassembly reaction), if two variable
                                positions are adjacent in the parent sequences, then they will remain linked
                                in all daughter sequences and the number of possible daughter sequences
                                and maximum observable crossover rate will be reduced accordingly.</p>
                        </div>
                        <p>Enter <i>L</i> = 1600, <i>N</i> = 1425, <i>m</i> = 2, and the variable nucleotide
                            positions &apos;250 274 375 650 655 757 763 982 991&apos; into the DRIVeR
                            form, and click the &apos;observable crossovers&apos; check-box. Select
                            the &apos;Calculate for the above parameters&apos; option and click &apos;Calculate&apos;.
                            You should get the answer that the expected number of distinct sequences
                            in the library is ~164, out of a total of 512 possible daughter sequences,
                            and that the true number of crossovers per daughter sequence is ~10 (<i>i.e.</i> about
                            one crossover per 140 nt on average). Following the link to &apos;More
                            statistics&apos; displays the probabilities of a crossover between each
                            pair of consecutive variable positions.</p>
                        <p>Alternatively, you could have chosen the &apos;Calculate and plot for
                            a range of values&apos; option on the base DRIVeR server page. This time
                            you get back three plots plus a link to the &apos;Statistics&apos; used
                            to draw the plots (useful if you want to find more accurate values than
                            you can read off the plots).</p>
                        <p>The plots can be useful for determining what library size or crossover
                            rate you should aim for in order to sample a given fraction of the potential
                            diversity. In the above example, if you wanted to sample all, or nearly
                            all, of the 512 possible daughter sequences, then you could use the third
                            plot (expected number of distinct sequences versus crossover rate and library
                            size). In order to sample all 512 possible daughter sequences, you could
                            either try to increase the crossover rate <i>m</i> or increase the library
                            size <i>L</i>. However, the plot shows that for <i>L</i> = 1600, <i>m</i>
would
                            have to be unrealistically large (crossovers every 5 nt, or more) in order
                            to sample all 512 possible daughter sequences. With a five-fold increase
                            in crossover rate (crossovers every 30 nt or so), there should be around
                            ~320 distinct daughter sequences. Alternatively, maintaining the current
                            crossover rate, and increasing the library size to 25600, should also result
                            in ~320 distinct daughter sequences.</p>
                    </div>
                     <h3>Caveats (<a data-toggle="collapse" href="#driver_caveats"><i class="fas fa-caret-down" aria-hidden="true"></i> show</a>)

                    </h3>
                    <div class="collapse" id="driver_caveats">
                        <p>DRIVeR uses a generic Poisson model of crossover probabilities and positions.
                            There are a few caveats that you should be aware of:</p>
                        <ul>
                            <li>Remember to use GLUE, not DRIVeR, when all daughter sequences are equally
                                likely (e.g. synthetic shuffling and SISDC).</li>
                            <li>In the current implementation of DRIVeR, you can not have more than two
                                different parent sequences.</li>
                            <li>As with PEDEL, there is the potential for amplification bias (see PEDEL
                                caveats)</li>
                            <li>The two parent sequences are assumed to be highly homologous. For parent
                                sequences that are homologous at the amino acid level but divergent at
                                the nucleotide level, crossovers preferentially occur in regions with greater
                                nucleotide sequence similarity. This bias is not reflected in the DRIVeR
                                model which, nevertheless, provides a useful upper bound on library diversity.
                                It has been suggested (Moore G.L., Maranas C.D., 2002, <i>Nuc. Acids. Res.</i>, <b>30</b>,
                                2407) that one way to reduce this bias is to synthesize new parent sequences
                                that maintain the amino acid sequences of the original parents, but have
                                greater similarity at the level of nucleotides. In the case of shuffling
                                two epPCR-generated clones, large-scale sequence dissimilarity will not
                                be an issue.</li>
                            <li>Any biases in library construction will decrease the actual number of
                                distinct variants represented in the library. In such cases, DRIVeR provides
                                the user with a useful upper bound on the diversity present in the library.</li>
                        </ul>
                        <p>Please refer to Patrick W. M., Firth A. E., Blackburn J.M., 2003, User-friendly
                            algorithms for estimating completeness and diversity in randomized protein-encoding
                            libraries, <i>Protein Eng.</i>, <b>16</b>, 451-457 for further discussion
                            of DRIVeR.</p>
                        <p>A good review of the sources of bias in recombination and other directed
                            evolution protocols can be found in Neylon C., 2004, Chemical and biochemical
                            strategies for the randomization of protein encoding DNA sequences: library
                            construction methods for directed evolution, <i>Nucleic Acids Res.</i>, <b>32</b>,
                            1448-1459.</p>
                    </div>
                </div>
                 <h3>Input</h3>
                <form>
                    <div class="row">
                        <div class="col-xl-3">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" title="Library size"
                                data-placement="top">
                                    <span class="input-group-text">Library size</span></div>
                                <input type="number" min="0" class="form-control"
                                placeholder="1600" id="driver_library_size">
                            </div>
                            <br>
                        </div>
                        <div class="col-xl-3">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" title="Sequence length in nucleotides (or amino acids) N"
                                data-placement="top">
                                    <span class="input-group-text">Length</span></div>
                                <input type="number" min="1" class="form-control"
                                       placeholder="1425" id="driver_length"> <div class="input-group-append"><span class="input-group-text">nt</span></div>
                            </div>
                            <br>
                        </div>
                        <div class="col-xl-3">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" title="Mean number of crossovers per sequence m"
                                data-placement="top">
                                    <span class="input-group-text">Mean</span></div>
                                <input type="number" min="0" class="form-control"
                                placeholder="2" id="driver_mean">
                            </div>
                            <br>
                        </div>
                        <div class="col-xl-6">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" title="Pedel is basic and nucleotide only, Pedel-AA is more advanced and has amino acids"
                                data-placement="top">
                                    <span class="input-group-text">Crossovers counting</span></div>
                                <input type="checkbox" class="switch"
                                id="driver_xtrue" checked data-off-text="Observable" data-on-text="All"
                                data-off-color="warning" data-size="large">
                            </div>
                            <br>
                        </div>
                        <div class="col-xl-6">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" title="Two alternative input ways"
                                data-placement="top">
                                    <span class="input-group-text">xover input</span></div>
                                <input type="checkbox" class="switch"
                                id="driver_mode" checked data-off-text="positions" data-on-text="sequences"
                                data-off-color="warning" data-size="large">
                            </div>
                            <br>
                        </div>
                    </div>
                    <div class="row" id="driver_by_seq">
                        <div class="col-xl-6">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" data-placement="top"
                                title="In frame sequence that was mutagenised.">
                                    <span class="input-group-text">Sequence</span>

                        </div>
                                <textarea class="form-control custom-control"
                                rows="5" style="resize:none" id="driver_sequenceA" name="driver_sequenceA"
                                placeholder="ATGCAA

ACGCTCAGCATCCAGCACGGTACCCTCGTCACGATGGATCAGTACCGCAGAGTCCTTGGG

GATAGCTGGGTTCACGTGCAGGATGGACGGATCGTCGCGCTCGGAGTGCACGCCGAGTCG

GTGCCTCCGCCAGCGGATCGGGTGATCGATGCACGCGGCAAGGTCGTGTTACCCGGTTTC

ATCAATGCCCACACCCATGTGAACCAGATCCTCCTGCGCGGAGGGCCCTCGCACGGGCGT

CAATTCTATGACTGGCTGTTCAACGTTGTGTATCCGGGACAAAAGGCGATGAGACCGGAG

GACGTAGCGGTGGCGGTGAGGTTGTATTGTGCGGAAGCTGTGCGCAGCGGGATTACGACG

ATCAACGAAAACGCCGATTCGGCCATCTACCCAGGCAACATCGAGGCCGCGATGGCGGTC

TATGGTGAGGTGGGTGTGAGGGTCGTCTACGCCCGCATGTTCTTTGATCGGATGGACGGG

CGCATTCAAGGGTATGTGGACGCCTTGAAGGCTCGCTCTCCCCAAGTCGAACTGTGCTCG

ATCATGGAGGAAACGGCTGTGGCCAAAGATCGGATCACAGCCCTGTCAGATCAGTATCAT

GGCACGGCAGGAGGTCGTATATCAGTTTGGCCCGCTCCTGCCACTACCACGGCGGTGACA

GTTGAAGGAATGCGATGGGCACAAGCCTTCGCCCGTGATCGGGCGGTAATGTGGACGCTT

CACATGGCGGAGAGCGATCATGATGAGCGGATTCATGGGATGAGTCCCGCCGAGTACATG

GAGTGTTACGGACTCTTGGATGAGCGTCTGCAGGTCGCGCATTGCGTGTACTTTGACCGG

AAGGATGTTCGGCTGCTGCACCGCCACAATGTGAAGGTCGCGTCGCAGGTTGTGAGCAAT

GCCTACCTCGGCTCAGGGGTGGCCCCCGTGCCAGAGATGGTGGAGCGCGGCATGGCCGTG

GGCATTGGAACAGATAACGGGAATAGTAATGACTCCGTAAACATGATCGGAGACATGAAG

TTTATGGCCCATATTCACCGCGCGGTGCATCGGGATGCGGACGTGCTGACCCCAGAGAAG

ATTCTTGAAATGGCGACGATCGATGGGGCGCGTTCGTTGGGAATGGACCACGAGATTGGT

TCCATCGAAACCGGCAAGCGCGCGGACCTTATCCTGCTTGACCTGCGTCACCCTCAGACG

ACTCCTCACCATCATTTGGCGGCCACGATCGTGTTTCAGGCTTACGGCAATGAGGTGGAC

ACTGTCCTGATTGACGGAAACGTTGTGATGGAGAACCGCCGCTTGAGCTTTCTTCCCCCT

GAACGTGAGTTGGCGTTCCTTGAGGAAGCGCAGAGCCGCGCCACAGCTATTTTGCAGCGG

GCGAACATGGTGGCTAACCCAGCTTGGCGCAGCCTCTAG"></textarea>
                            </div>
                            <br>
                        </div>
                        <div class="col-xl-6">
                            <div class="input-group">
                                <div class="input-group-prepend" data-toggle="tooltip" data-placement="top"
                                title="In frame sequence that was mutagenised.">
                                    <span class="input-group-text">Sequence</span>

                        </div>
                                <textarea class="form-control custom-control"
                                rows="5" style="resize:none" id="driver_sequenceB" name="driver_sequenceB"
                                placeholder="ATGCAAACGCTCAGCATCCAGCACGGTACCCTCGTCACGATGGATCAGTACCGCAGAGTCCTTGGGGATA

GCTGGGTTCACGTGCAGGATGGACGGATCGTCGCGCTCGGAGTGCACGCCGAGTCGGTGCCTCCGCCAGC

GGATCGGGTGATCGATGCACGCGGCAAGGTCGTGTTACCCGGTTTCATCAATGCCCACACCCATGTGAAC

CAGATCCTCCTGCGCGGAGGGCCCTCGCACGGGCGTCAACTCTATGACTGGCTGTTCAACGTTTTGTATC

CGGGACAAAAGGCGATGAGACCGGAGGACGTAGCGGTGGCGGTGAGGTTGTATTGTGCGGAAGCTGTGCG

CAGCGGGATTACGACGATCAACGACAACGCCGATTCGGCCATCTACCCAGGCAACATCGAGGCCGCGATG

GCGGTCTATGGTGAGGTGGGTGTGAGGGTCGTCTACGCCCGCATGTTCTTTGATCGGATGGACGGGCGCA

TTCAAGGGTATGTGGACGCCTTGAAGGCTCGCTCTCCCCAAGTCGAACTGTGCTCGATCATGGAGGAAAC

GGCTGTGGCCAAAGATCGGATCACAGCCCTGTCAGATCAGTATCATGGCACGGCAGGAGGTCGTATATCA

GTTTGGCCCGCTCCTGCCATTACCCCGGCGGTGACAGTTGAAGGAATGCGATGGGCACAAGCCTTCGCCC

GTGATCGGGCGGTAATGTGGACGCTTCACATGGCGGAGAGCGATCATGATGAGCGGCTTCATTGGATGAG

TCCCGCCGAGTACATGGAGTGTTACGGACTCTTGGATGAGCGTCTGCAGGTCGCGCATTGCGTGTACTTT

GACCGGAAGGATGTTCGGCTGCTGCACCGCCACAATGTGAAGGTCGCGTCGCAGGTTGTGAGCAATGCCT

ACCTCGGCTCAGGGGTGGCCCCCGTGCCAGAGATGGTGGAGCGCGGCATGGCCGTGGGCATTGGAACAGA

TGACGGGAATTGTAATGACTCCGTAAACATGATCGGAGACATGAAGTTTATGGCCCATATTCACCGCGCG

GTGCATCGGGATGCGGACGTGCTGACCCCAGAGAAGATTCTTGAAATGGCGACGATCGATGGGGCGCGTT

CGTTGGGAATGGACCACGAGATTGGTTCCATCGAAACCGGCAAGCGCGCGGACCTTATCCTGCTTGACCT

GCGTCACCCTCAGACGACTCCTCACCATCATTTGGCGGCCACGATCGTGTTTCAGGCTTACGGCAATGAG

GTGGACACTGTCCTGATTGACGGAAACGTTGTGATGGAGAACCGCCGCTTGAGCTTTCTTCCCCCTGAAC

GTGAGTTGGCGTTCCTTGAGGAAGCGCAGAGCCGCGCCACAGCTATTTTGCAGCGGGCGAACATGGTGGC

TAACCCAGCTTGGCGCAGCCTCTAG"></textarea>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="row">
                        <div class="col-xl-5" id="driver_by_list">
                            <div class="input-group"> <div class="input-group-prepend" data-toggle="tooltip" data-placement="top"
                                title="Positions of variable nucleotides (or amino acids). (Maximum 15 or 20)">
                                <span class="input-group-text">Positions</span>

                        </div>
                                <textarea class="form-control custom-control"
                                rows="2" style="resize:none" id="driver_positions" name="sequence" placeholder="250 274 375 650 655 757 763 982 991"></textarea>
                            </div>
                            <br>
                        </div>
                    </div>
                    <!-- row-->
                </form>
                <div class="row">
                    <div class="col-xl-6 offset-lg-3">
                        <div class="btn-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-warning" id="driver_clear"><i class="fas fa-eraser" aria-hidden="true"></i>
Clear</button>
                            <button type="button"
                            class="btn btn-info" id="driver_demo"><i class="fas fa-gift"></i> Demo</button>
                            <button type="button"
                            class="btn btn-success" id="driver_calculate"><i class="fas fa-exchange" aria-hidden="true"></i>
Calculate</button>
                        </div>
                    </div>
                    <br>
                </div>
                <!-- The results -->
                <div class="row hidden" id="driver_result">
                    <div class="alert alert-danger" role="alert"><span class="pycorpse"></span> Oh Snap. Something went wrong</div>
                    <br>
                </div>
            </div>
        </div>