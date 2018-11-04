<div class="card" id="pedelAA">
    <div class="card-header">
        <h1 class="card-title">PedelAA</h1>
    </div>
    <div class="card-body">
        <h2>PedelAA</h2>
        <div id="pedelAA_intro">
            <h3>Description</h3>
            <p>Short paragraph goes here.</p>
            <h3>Overview (<a data-toggle="collapse" href="#pedelAA_overview"><i class="fa fa-caret-down"
                                                                                aria-hidden="true"></i> show</a>)

            </h3>
            <div class="collapse" id="pedelAA_overview">
                <p>PEDEL-AA is an extension to amino acid sequences of the original
                    nucleotide version of PEDEL (see links to publications and
                    <a href="/static/pedelAA_math_notes.pdf">mathematics notes</a> from the statistics
                    <a href="/">home</a> page). Due to the more complex problem
                    of estimating diversity and completeness at the amino acid level (as
                    opposed to nucleotides and codons), there are some major differences
                    in the algorithms and a few extra approximations. A brief description
                    of the procedure follows.</p>
                <p>First, to recapitulate the nucleotide version of PEDEL: As discussed
                    in the <a href="/static/pedelAA_math_notes.pdf">mathematics notes</a>, for the nucleotide
                    version, if the input library is conceptually divided into
                    sub-libraries Lx (x=0,1,2,...) where the sub-library Lx comprises all
                    variants in the library with exactly x nucleotide substitutions, then
                    the PEDEL scenario divides into two regions:

                <ol>

                    <li> where Lx is large compared with Vx (the number of possible
                        variants with exactly x substitutions) then Cx (the expected number
                        of distinct sequences in Lx) is approximately equal to Vx, and
                    </li>

                    <li> where Lx is small compared with Vx, then Cx is approximately
                        equal to Lx.
                    </li>

                </ol>
                <p>
                    In the transition region (where Lx ~ Vx) we can calculate Cx with
                    the formula Cx ~ Vx(1-exp(-Lx/Vx)). This is based on the assumption
                    that all variants in Vx are equiprobable, so the mean number of
                    occurrences in the sub-library Lx of each variant in Vx is Lx/Vx and,
                    assuming Poisson statistics, the probability that any given variant is
                    present in the sub-library is 1-exp(-Lx/Vx), so the expected number of
                    distinct variants present in the sub-library is Cx ~
                    Vx(1-exp(-Lx/Vx)).</p>
                <p>In the more complex scenario presented in PEDEL-AA, the assumption of
                    equiprobable variants breaks down for two reasons: (i) we have
                    introduced a full 4 x 4 nucleotide substitution matrix (in particular
                    the transition:transversion ratio is not assumed to be unity), and
                    (ii) even if nucleotide substitutions were equiprobable, the
                    corresponding amino acid substitutions are not. However we may still
                    borrow some concepts from the equiprobable nucleotide version of PEDEL
                    - namely, (1) when Lx is small compared with Vx, then Cx is
                    approximately equal to Lx, and (2) when Lx is large compared with Vx
                    then Cx is approximately equal to Vx. However these concepts need
                    some refining, as follows.</p>

                <ol>

                    <li> Instead of x counting the number of nucleotide substitutions, we
                        now let x count the number of amino acid substitutions
                        (i.e. non-synonymous, non-stop codon, substitutions). Note that the
                        substitution rate on the PEDEL-AA input form is the mean number
                        of <i>nucleotide</i> substitutions, <i>nsubst</i>, per variant but,
                        using this, the programme calculates the expected mean number of
                        nonsynonymous amino acid substitutions per variant. The probability
                        distribution, P(x_nt), of the number of nucleotide substitutions,
                        x_nt, per variant may be assumed to follow
                        the <a href=pedelpcrdist.html>PCR distribution</a> (with
                        mean <i>nsubst</i>, and the extra parameters <i>ncycles</i>
                        and <i>eff</i>, respectively the number of PCR cycles and the PCR
                        <a href=/cgi-bin/aef/PCReff.pl>efficiency</a>). Separate statistics
                        are also calculated assuming that the number of nucleotide
                        substitutions per variant follows a Poisson distribution (with the
                        single parameter <i>nsubst</i>), and these results may be used if the
                        PCR <i>ncycles</i> and <i>eff</i> parameters are unknown.
                    </li>
                    <p>
                        The probabilities of variants being truncated (i.e. containing
                        introduced stop codons) are then subtracted from the P(x_nt)
                        distributions. Clearly this is an increasing function of x_nt and, by
                        x_nt = 100, typically less than 0.6% of variants are stop-codon free.
                        Note that the P(x_nt) will no longer sum up to unity; instead (after
                        discarding indel-containing variants) they sum up
                        to <i>L_eff</i> / <i>L_tot</i>, where <i>L_eff</i> is the 'effective'
                        library size (i.e. the number of variants with no indels or stop
                        codons) and <i>L_tot</i> is the total library size (albeit again
                        excluding variants with indels).</p>
                    <p>
                        Next, the Poisson and PCR P(x_nt) distributions are redistributed into
                        amino acid P(x_aa) distributions. First the mean number, <i>frac</i>,
                        of nonsynonymous amino acid substitutions per nucleotide substitution
                        (given that the nucleotide substitution doesn't produce a stop codon)
                        is calculated. Typically <i>frac</i> ~ 2/3. For each x_nt, the
                        number of nonsynonymous amino acid substitutions resulting from
                        exactly x_nt nucleotide substitutions is assumed to follow a binomial
                        distribution, B(x_nt,<i>frac</i>) (i.e. x_nt 'trials'; probability of
                        'success' per 'trial' = <i>frac</i>). Summing up the binomial
                        distributions, each weighted by P(x_nt), for x_nt = 0,1,2,...,100
                        gives the amino acid Poisson and PCR P(x_aa) distributions. Of
                        course, Sum_{x_nt} P(x_nt) = Sum_{x_aa} P(x_aa) = <i>L_eff</i>
                        / <i>L_tot</i>. The Poisson and PCR amino acid sub-library sizes, Lx,
                        are given by P(x_aa) x <i>L_tot</i>.</p>
                    <p>
                        All these estimates rely on the mean number of nucleotide
                        substitutions per variant, <i>nsubst</i>, being relatively small
                        compared with the number of codons in the sequence, so that multiple
                        substitutions in the same codon are not very common. In practice, we
                        limit <i>nsubst</i> <= 0.1 x input sequence length (in
                        nucleotides). In fact, for the Poisson case, we can calculate L0, L1
                        and L2 exactly (a sum over all possible variants with exactly 0, 1 or
                        2 amino acid substitutions, multiplied by their probabilities given by
                        the input nucleotide substitution matrix and <i>nsubst</i>, multiplied
                        by <i>L_tot</i>). These calculations agree very well with the 'sum of
                        binomial distributions' method. For example, for the library
                        presented in Volles & Lansbury (2005), we have
                    <pre>
                'exact'       'binomial sum'
                L0     3.763e+05         3.861e+05
                L1     8.174e+05         8.205e+05
                L2     8.795e+05         8.717e+05
                </pre>
                    </li>

                    <li> Two estimates of Vx are calculated. The first, Vx_1, is an
                        estimate of the number of 'common' variants with exactly x amino acid
                        substitutions - namely those variants where each substituted amino
                        acid is accessible by just a single nucleotide substitution in the
                        respective codon. The second, Vx_2, is the total number of possible
                        amino acid variants with exactly x amino acid substitutions. Although
                        most variants in a sub-library will be of type Vx_1, variants of type
                        Vx_2 may contribute significantly to the total number of distinct
                        variants Cx when the sub-library size Lx is large compared with the
                        number of variants Vx_1. When the sub-library size Lx is small
                        compared with the number of variants Vx_1, nearly every variant in Lx
                        is distinct (i.e. Cx ~ Lx) and it doesn't matter whether these
                        variants are of type Vx_1 or Vx_2.
                    </li>

                    <ul>

                        <li>Vx_2 is given by C(N,x) 19^x, where C(N,x) is the combinatorial
                            function, i.e. C(N,x) = N!/[x!(N-x)!], and N is the length of
                            the input sequence in codons. (Cf equation (5) of the
                            <a href="/static/pedelAA_math_notes.pdf">mathematical notes</a> for the nucleotide
                            version of PEDEL.)
                        </li>

                        <li>We estimate Vx_1 with the formula C(N,x) A^x, where A is the
                            mean number of non-synonymous amino acid substitutions
                            accessible by a single nucleotide substitution, for the input
                            sequence (the value of A is given on the results page).
                        </li>

                    </ul>

                    Calculation of A: For each codon, i, in the parent sequence, the
                    number of non-synonymous, non-stop codon, amino acid substitutions Ai,
                    i=1,...,N (N = parent sequence length in codons) accessible by a
                    single nucleotide substitution is calculated. Such substitutions are
                    accessible with similar probability (albeit varying by a factor of ~3
                    for a typical transition:transversion ratio) and much higher
                    probability than amino acid substitutions only accessible via 2 or 3
                    nucleotide substitutions in the same codon (except in the case of a
                    short parent sequence and/or high mutation rate). The Ai are averaged
                    (geometric mean) over the sequence to give the parameter A = (A1 x A2
                    x ... x An)^(1/N). A is typically around 5.8.</li>

                    <li> When Lx << Vx then Cx ~ Lx. For equiprobable variants this
                        approximation is good to 5% for Lx < 0.1 Vx (see the mathematical
                        <a href=/static/notes.pdf>notes</a> on the nucleotide version of PEDEL).
                        For PEDEL-AA, we use this approximation when Lx < 0.1 Vx_1 (the number
                        of 'easy-to-reach' variants) or more rigorously, and optionally, when
                        Rx < 0.1, where Rx is the mean frequency of the most common variant in
                        the sub-library Lx (see <a data-toggle="modal" data-target="#pedelAA_exact_modal">note on Rx
                            statistic</a> for details). Lx < 0.1 Vx_1 is usually true for x
                        >= 3 and almost always true for x >= 4. For example for N >= 40
                        codons, V3_1 >= ~5.8^3 x C(40,3) = 1.9 x 10^6 and V4_1 >= ~5.8^4 x
                        C(40,4) = 1.0 x 10^8, while for N >= 100 codons, V3_1 >= ~5.8^3 x
                        C(100,3) = 3.1 x 10^7 and V4_1 >= ~5.8^4 x C(100,4) = 4.4 x 10^9; and
                        remember these Vx_1 sizes only need to be compared with the relevant
                        sub-library size L3 or L4, not the whole library size. In the Cx ~ Lx
                        region, whether a particular variant is of type Vx_1 or type Vx_2 is
                        irrelevant - either way it will (almost) always be a distinct variant
                        in the library.
                    </li>

                    <li> For x = 0, 1 and 2, we calculate the expected number of distinct
                        variants, Cx, precisely. This calculation includes variants with
                        multiple nucleotide substitutions in the same codon (i.e. both Vx_1
                        and Vx_2).

                        The total number of each of the 64 codon types in the input sequence
                        is calculated. The 64 x 20 matrix of probabilities for each codon
                        type mutating to each amino acid type is calculated using the input
                        nucleotide substitution matrix and the input substitution rate.

                        For x = 0, 1 and 2 there are, respectively Vx_2 = 1, 19N and
                        361N(N-1)/2 total possible variants (i.e. N!/[x!(N-x)!] 19^x, where N
                        is the length of the input sequence in codons). The probability of
                        the input sequence mutating to each of these possible variants is
                        calculated and renormalized by the respective probability sum P0, P1
                        or P2 (where Px = Sum_{v_i in Vx_2} P(v_i)) to give the normalized
                        probabilities Pn(v_i) of the different variants within the respective
                        sub-libraries Lx, rather than within the whole library. The
                        probability of a particular variant v_i being present in the relevant
                        sub-library Lx is given by 1 - exp(-Pn(v_i) x Lx). These
                        probabilities are quickly summed over all possible variants using the
                        codon counts. Computationally, this is very fast for x = 0, 1 and 2,
                        but can take a few minutes for x = 3; hence the 'exact' calculation is
                        not used on the webserver for x >= 3. The sizes of the sub-libraries
                        Lx are determined separately for the Poisson and PCR distributions as
                        described above, thus resulting in separate Cx estimates for the
                        different distributions.
                    </li>

                    <li> Ideally, for x >= 3, we will enter the Cx ~ Lx region. In this
                        case all the individual Cx estimates, and the estimated total number
                        of distinct variants in the library C = C0 + C1 + C2 + ..., will be
                        fairly good. A warning is printed in the 'notes' column of the output
                        table of sub-library statistics if there are any x >= 3 values for
                        which the Cx ~ Lx approximation may not apply, in which case Cx is
                        estimated with the formula Cx ~ Vx_1(1-exp(-Lx/Vx_1)) (i.e. ignoring,
                        in these particular sub-libraries, any variants of type Vx_2). This
                        formula is not very accurate and may result in an overestimate
                        (because the Vx_1 are not equiprobable - the higher probability amino
                        acid substitutions [e.g. those accessible by transitions, or via more
                        than one possible nucleotide substitution] will be over-represented at
                        the expense of other amino acid substitutions) or an underestimate
                        (since the Vx_2 variants are ignored). These effects can be quite a
                        large (e.g. if some Vx_1 substitutions are 3 times more likely than
                        others, and the Lx ~ Vx_1 turnover occurs at x ~ 3, then the most
                        common three-amino acid substitutions will be 3^3 = 27 times more
                        likely than the rarest three-amino acid substitutions).
                    </li>

                </ol>
                <p>
                    <b>Note that the introduced stop codon and indel statistics and graphs
                        are exact calculations (based on the input substitution, indel and
                        nucleotide matrix parameters) and do not use any of the above
                        approximations (except Poisson statistics). The above approximations
                        are only used for the library completeness statistics.</b></p>
                <h4>Comparison with Volles & Lansbury (2005) Monte Carlo
                    simulation.</h4>
                <table class="table table-striped">
                    <tr>
                        <th>Property</th>
                        <th align="center">Volles & Lansbury</th>
                        <th colspan="2" align="center">Firth & Patrick</th>
                    </tr>
                    <tr>
                        <td align="center">-</td>
                        <td align="center">-</td>
                        <td align="center">Poisson</td>
                        <td align="center">PCR</td>
                    </tr>
                    <tr>
                        <td align="left">Truncations (%)</td>
                        <td align="center">15</td>
                        <td align="center" colspan="2">15.6</td>
                    </tr>
                    <tr>
                        <td align="left"># Full-length clones</td>
                        <td align="center">3.1 x 10^6</td>
                        <td align="center" colspan="2">3.18 x 10^6</td>
                    </tr>
                    <tr>
                        <td align="left">Protein mutation freq. per aa</td>
                        <td align="center">0.016</td>
                        <td align="center" colspan="2">0.0160</td>
                    </tr>
                    <tr>
                        <td align="left">Mean # mutations per protein</td>
                        <td align="center">2.1</td>
                        <td align="center" colspan="2">2.12</td>
                    </tr>
                    <tr>
                        <td align="left">Unmutated sequences (%)*</td>
                        <td align="center">14</td>
                        <td align="center">10.1</td>
                        <td align="center">14.0</td>
                    </tr>
                    <tr>
                        <td align="left"><b># of unique proteins</b></td>
                        <td align="center"><b>1.3 x 10^6</b></td>
                        <td align="center"><b>1.32 x 10^6</b></td>
                        <td align="center"><b>1.29 x 10^6</b></td>
                    </tr>
                    <tr>
                        <td align="left"># of unique point mutations</td>
                        <td align="center">1990</td>
                        <td align="center" colspan="2">1989</td>
                    </tr>
                    <tr>
                        <td align="left"># of unique single point mutations</td>
                        <td align="center">1566</td>
                        <td align="center">1618</td>
                        <td align="center">1618</td>
                    </tr>
                </table>
                <br>

                * Relative to the total library size (i.e. including truncated variants).


                <h4>References</h4>

                <li>Volles M.J., Lansbury P.T. Jr. (2005). A computer program for the
                    estimation of protein and nucleic acid sequence diversity in random
                    point mutagenesis libraries, <i>Nucleic Acids Res.</i>
                    <b>33</b>, 3667-3677.
                </li>


            </div>


            <h3 id="pedelAA_Rx">Note on R<sub>x</sub> statistics (<a data-toggle="collapse" href="#pedelAA_Rx_note"><i
                    class="fa fa-caret-down" aria-hidden="true"></i> show</a>)

            </h3>
            <div class="collapse" id="pedelAA_Rx_note"></div>


            <p>The 'Lx < 0.1 Vx_1' criterion for deciding when to use
                the 'Cx ~ Lx'
                approximation is sometimes inaccurate, and can be refined as
                follows.</p>
            <p>First consider a single nucleotide substitution in a single codon. There
                are 9 possible mutated codons. An amino acid mutation that can only
                be coded by a single codon out of the 9 and that requires a
                transversion, has only a 1 in 15 probability (assuming a
                transition:transversion ratio of 3), since if p is the probability of
                a transversion, then 3p is the probability of a transition, and the
                total probability of the 9 mutated codons is 6(p) + 3(3p) = 15p.</p>
            <p>For example, if the parent codon is GGG (Gly), then the 9
                single-nucleotide-substitution codons are</p>
            <table class="table table-striped">
                <tr>
                    <th>codon</th>
                    <th>amino acid</th>
                    <th>relative probability</th>
                </tr>
                <tr>
                    <td>AGG</td>
                    <td>Arg</td>
                    <td>3p</td>
                </tr>
                <tr>
                    <td>CGG</td>
                    <td>Arg</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>TGG</td>
                    <td>Trp</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>GAG</td>
                    <td>Glu</td>
                    <td>3p</td>
                </tr>
                <tr>
                    <td>GCG</td>
                    <td>Ala</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>GCG</td>
                    <td>Ala</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>GTG</td>
                    <td>Val</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>GGA</td>
                    <td>Gly</td>
                    <td>3p</td>
                </tr>
                <tr>
                    <td>GGC</td>
                    <td>Gly</td>
                    <td>p</td>
                </tr>
                <tr>
                    <td>GGT</td>
                    <td>Gly</td>
                    <td>p</td>
                </tr>
            </table>
            <br/>

            <table table="table table-striped">
                <tr>
                    <th>AA</th>
                    <th>Probabilities given the <i>codon</i> mutates</th>
                    <th>Probabilities given the <i>amino acid</i> mutates</th>
                </tr>
                <tr>
                    <td>Gly</td>
                    <td>5/15</td>
                    <td>(wild-type)</td>
                </tr>
                <tr>
                    <td>Arg</td>
                    <td>4/15</td>
                    <td>4/10</td>
                </tr>
                <tr>
                    <td>Glu</td>
                    <td>3/15</td>
                    <td>3/10</td>
                </tr>
                <tr>
                    <td>Trp</td>
                    <td>1/15</td>
                    <td>1/10</td>
                </tr>
                <tr>
                    <td>Ala</td>
                    <td>1/15</td>
                    <td>1/10</td>
                </tr>
                <tr>
                    <td>Val</td>
                    <td>1/15</td>
                    <td>1/10</td>
                </tr>
            </table>

            <p>The 'Lx < 0.1 Vx_1' criterion assumes that all of the
                single-nucleotide-substitution non-synonymous amino acid substitutions
                are equiprobable - i.e. 1 in 5 in the above example, but in general
                represented by the reciprocal of the 'A' factor described in
                the above section,
                where typically A ~ 5.8; whereas, in fact, the most common
                single-nucleotide-substitution amino acid substitution (GGG -> Arg) is
                4 x as likely as the rarest (GGG -> Trp or Ala or Val). In cases
                where some nucleotide substitutions (as defined by the 4 x 4
                nucleotide substitution matrix) are particularly rare, the probability
                difference between the rarest and the most common
                single-nucleotide-substitution amino acid substitutions at a given
                site can be much greater.</p>
            <p>The 'Lx < 0.1 Vx_1' criterion for being in the 'Cx ~ Lx' region
                is
                basically to make sure that there are enough variants in Vx to
                'absorb' all Lx sub-library members so that (within a small error) at
                most one sub-library member is equal to any given variant in Vx. In
                practice, it doesn't matter what the probability of the rarest
                variants is. What matters for the 'Cx ~ Lx' approximation is that the
                mean frequency in Lx of the most common variant is < 0.1. In fact the
                mean frequency of the most common variant in Lx, which we denote by
                Rx, is easy to calculate for x = 0, 1, 2, ..., 20, ..., and is shown
                in the PEDEL-AA output table of sub-library statistics.</p>
            <p>Using these Rx values, the 'Lx < 0.1 Vx_1' criterion would be replaced
                with the criterion 'Rx < 0.1'. In practice this means that if, in the
                table of sub-library statistics, there are Rx values > 0.1, for which
                the 'Cx ~ Lx' approximation has been used (i.e. x >= 3 and Lx < 0.1
                Vx_1), then the particular corresponding Cx values may be
                overestimates. A warning and html link are given in the table of
                sub-library statistics whenever this occurs.</p></div>


        <div id="pedelAA_input">
            <h3>Input</h3>
            <div class="row">
                <!--section-->
                <h4>Sequence</h4>
                <p>In frame sequence that was mutagenised. Note that all symbols that aren&apos;t
                    uppecase ATUGC, will be discarded along with a Fasta header (<i>e.g.</i> &apos;&gt;T.
                    maritima Cystathionine &#x3B2;-lyase&apos;), therefore for masked sequences
                    use lowercase.</p>
                <div class="col-xl-12">
                    <div class="input-group"> <span class="input-group-addon" data-toggle="tooltip" data-placement="top"
                                                    title="In frame sequence that was mutagenised.">Sequence

                        </span>
                        <textarea class="form-control custom-control"
                                  rows="5" style="resize:none" id="pedelAA_sequence" name="pedelAA_sequence">ATGGTGAGCAAGGGCGAGGAGCTGTTCACCGGGGTGGTGCCCATCCTGGTCGAGCTGGACGGCGACGTAAACGGCCACAAGTTCAGCGTCCGCGGCGAGGGCGAGGGCGATGCCACCAACGGCAAGCTGACCCTGAAGTTCATCTGCACCACCGGCAAGCTGCCCGTGCCCTGGCCCACCCTCGTGACCACCTTCGGCTACGGCGTGGCCTGCTTCAGCCGCTACCCCGACCACATGAAGCAGCACGACTTCTTCAAGTCCGCCATGCCCGAAGGCTACGTCCAGGAGCGCACCATCTCTTTCAAGGACGACGGTACCTACAAGACCCGCGCCGAGGTGAAGTTCGAGGGCGACACCCTGGTGAACCGCATCGAGCTGAAGGGCATCGACTTCAAGGAGGACGGCAACATCCTGGGGCACAAGCTGGAGTACAACTTCAACAGCCACTACGTCTATATCACGGCCGACAAGCAGAAGAACTGCATCAAGGCTAACTTCAAGATCCGCCACAACGTTGAGGACGGCAGCGTGCAGCTCGCCGACCACTACCAGCAGAACACCCCCATCGGCGACGGCCCCGTGCTGCTGCCCGACAACCACTACCTGAGCCATCAGTCCAAGCTGAGCAAAGACCCCAACGAGAAGCGCGATCACATGGTCCTGCTGGAGTTCGTGACCGCCGCCGGGATTACACATGGCATGGACGAGCTGTACAAGTAA</textarea>
                        <span
                                class="input-group-addon">Retrieve previous
                    <br>
                    <button class="btn btn-secondary" type="button" id="pedelAA_sequence_retrieve"
                            data-toggle="tooltip" data-placement="top"
                            title="In frame sequence that was mutagenised."><i class="fa fa-history"></i>
                    </button>
                    </span>
                    </div>
                    <br>
                </div>
                <br>
            </div>
            <div class="row">
                <div class="col-xl-5">
                    <div class="input-group"> <span class="input-group-addon" data-toggle="tooltip"
                                                    title="Library size L"
                                                    data-placement="top">Library size</span>
                        <input type="number" min="0" class="form-control"
                               placeholder="10000000" id="pedelAA_size"> <span class="input-group-addon">nt</span>
                    </div>
                    <br>
                </div>
            </div>
            <h4>Nucleotide mutation matrix</h4>
            (non-negative numbers. Overall scaling is unimportant as this is taken
            from the &apos;mean number of substitutions per daughter sequence&apos;
            parameter.)
            <div class="row">
                <div class="col-xl-12">
                    <table>
                        <tr>
                            <td></td>
                            <td align="center"><b>To</b>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle"><b>From</b>&#xA0;&#xA0;</td>
                            <td>
                                <table width="50%" border="0" id="mutTable_raw">
                                    <thead>
                                    <tr></tr>
                                    <tr>
                                        <th width="20%"></th>
                                        <th width="20%">A</th>
                                        <th width="20%">T</th>
                                        <th width="20%">G</th>
                                        <th width="20%">C</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <th>A</th>
                                        <td>
                                            <input class="mutation_identity" type="text" disabled id="A2A"
                                                   value="&#x2014;">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" type="text" id="A2T" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_Rtransition" id="A2G" type="text" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" id="A2C" type="text" value="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="20%">T</th>
                                        <td width="20%">
                                            <input class="mutation_transversion" type="text" id="T2A" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_identity" type="text" disabled id="T2T"
                                                   value="&#x2014;">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" id="T2G" type="text" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_Ytransition" id="T2C" type="text" value="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="20%">G</th>
                                        <td width="20%">
                                            <input class="mutation_Rtransition" type="text" id="G2A" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" type="text" id="G2T" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_identity" disabled id="G2G" type="text"
                                                   value="&#x2014;">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" id="G2C" type="text" value="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">C</td>
                                        <td width="20%" bgcolor="#FFFF99">
                                            <input type="text" id="C2A" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_Ytransition" type="text" id="C2T" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_transversion" id="C2G" type="text" value="0">
                                        </td>
                                        <td>
                                            <input class="mutation_identity" disabled id="C2C" type="text"
                                                   value="&#x2014;">
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br>
                </div>
                <div class="col-xl-6 offset-lg-2">
                    <div class="btn-group btn-group-justified" role="group" aria-label="...">
                        <div class="btn-group" role="group">
                            <label class="btn btn-secondary btn-file" id="pedelAA_load_group"> <i class="fa fa-upload"
                                                                                                  aria-hidden="true"></i>
                                Load
                                <input type="file"
                                       id="pedelAA_load_spectrum" style="display: none;">
                            </label>
                        </div>
                        <div class="btn-group" role="group">
                            <label class="btn btn-secondary btn-file" id="pedelAA_save_spectrum"> <i
                                    class="fa fa-download"
                                    aria-hidden="true"></i>
                                Save</label>
                        </div>
                        <div class="btn-group" role="group">
                            <label class="btn btn-secondary btn-file" id="pedelAA_retrieve_spectrum"> <i
                                    class="fa fa-history"
                                    aria-hidden="true"></i>
                                Previous</label>
                        </div>
                        <div class="btn-group" role="group">
                            <label class="btn btn-secondary dropdown-toggle" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">Preset <span class="caret"></span>
                            </label>
                            <ul class="dropdown-menu">
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_mutazyme">Mutazyme II</span>
                                </li>
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_manganese">Mn Taq</span>
                                </li>
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_D473G">Pfu D215A D473G</span>
                                </li>
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_analogues">dNTP oxodGTP</span>
                                </li>
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_MP6">MP6</span>
                                </li>
                                <li class="fake-link dropdown-item"><span id="pedelAA_opt_uniform">Uniform</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <br>
                </div>
                <br>
            </div>
            <div class="row">
                <div class="col-xl-4">
                    <div class="input-group">
                        <input type="checkbox" class="switch" id="pedelAA_normal" data-off-text="Unnormalised"
                               data-on-text="Normalised" data-off-color="warning"> <span class="input-group-addon">values</span>
                    </div>
                </div>
                <div class="col-xl-4">
                    <div class="input-group"> <span class="input-group-addon" data-toggle="tooltip"
                                                    title="Mean number of nucleotide substitutions per daughter sequence"
                                                    data-placement="top">Load</span>
                        <input type="number" min="0" class="form-control"
                               placeholder="4.5" id="pedelAA_load"> <span class="input-group-addon">mutations/seq</span>
                    </div>
                </div>
                <br>
            </div>
            <div class="row">
                <div id="pedelAA_&#xA7;cycles" class="card bg-light card-body mb-3 well-lg">
                    <div class="col-xl-4">
                        <div class="input-group"> <span class="input-group-addon" data-toggle="tooltip"
                                                        title="Number of PCR cycles"
                                                        data-placement="top">PCR cycles</span>
                            <input type="number" min="0" class="form-control"
                                   placeholder="4.5" id="pedelAA_cycles">
                        </div>
                        <br>
                    </div>
                    <div class="col-xl-4">
                        <div class="input-group"> <span class="input-group-addon" data-toggle="tooltip"
                                                        title="PCR efficiency"
                                                        data-placement="top">PCR efficiency</span>
                            <input type="number" min="0"
                                   max="1" class="form-control" placeholder="0.6" id="pedelAA_efficiency">
                        </div>
                        <br>
                    </div>
                    <div class="col-xl-2">
                        <button type="button" class="btn btn-info" data-toggle="modal"
                                data-target="#pedelAA_calc_modal"><i
                                class="fa fa-calculator" aria-hidden="true"></i> Calculator
                        </button>
                        <br>
                    </div>
                    <br>
                </div>
            </div>
            <!-- <p>For a note about Poisson vs. PCR distribution see <a href="#" data-toggle="modal"

                                                                                    data-target="#pedel_note">here</a>.</p>-->
            <!--button row-->
            <div class="row">
                <div class="col-xl-6 offset-lg-3">
                    <div class="btn-group" role="group" aria-label="...">
                        <button type="button" class="btn btn-warning" id="pedelAA_clear"><i class="fa fa-eraser"
                                                                                            aria-hidden="true"></i>
                            Clear
                        </button>
                        <button type="button"
                                class="btn btn-info" id="pedelAA_demo"><i class="fa fa-gift" aria-hidden="true"></i>
                            Demo
                        </button>
                        <button type="button"
                                class="btn btn-success" id="pedelAA_calculate"><i class="fa fa-exchange"
                                                                                  aria-hidden="true"></i>
                            Calculate
                        </button>
                    </div>
                </div>
                <br>
            </div>
        </div>
        <div class="row hidden" id="pedelAA_result">
            <div class="alert alert-danger" role="alert"><span class="pycorpse"></span> Oh Snap. Something went wrong
            </div>
            <br>
        </div>
        <!-- Modals -->
        <div id="pedelAA_calc_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&#xD7;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <p>Some text in the modal.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modals -->
        <div id="pedel_note" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&#xD7;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <p>In our paper (Firth &amp; Patrick, 2005), we assumed a Poisson distribution
                            to determine the fraction of sequences in an epPCR library that contain
                            exactly 0, 1, 2, 3, ... mutations, given the mean number of mutations, <i>m</i>,
                            per sequence.</p>
                        <p>Since publication of Firth &amp; Patrick (2005), however, Drummond et
                            al. (2005) have revisited the pioneering work of Sun (1995) and provided
                            experimental evidence in support of his more accurate equation describing
                            the distribution of <i>m</i>. This &apos;PCR distribution&apos; takes into
                            account the number of PCR thermal cycles <i>ncycles</i> and the PCR efficiency <i>eff</i>
                            (i.e.
                            the probability that any particular sequence is duplicated in a given PCR
                            cycle). We have therefore now included the PCR distribution as an optional
                            alternative to the Poisson distribution in PEDEL.</p>
                        <p>For large <i>m</i>, small <i>ncycles</i>, or low <i>eff</i>, the PCR distribution
                            is broader than the Poisson distribution. For low <i>m</i>, large <i>ncycles</i> and
                            large <i>eff</i>, the PCR distribution approximates the Poisson distribution.
                            In a &apos;typical&apos; epPCR (e.g. <i>ncycles</i> = 30, <i>eff</i> = 0.6, <i>m</i> =
                            4), the estimated total number of distinct sequences in a library typically
                            agrees to within 5% for the two distributions, though the sub-library statistics
                            can show more variation.</p>
                        <p>If you know <i>ncycles</i> and <i>eff</i>, then we recommend that you use
                            the PCR distribution instead of the Poisson distribution. Drummond et al.
                            (2005) use the formula <i>d</i> = <i>ncycles</i> &#xD7; <i>eff</i>, where <i>d</i> is
                            the number of doublings. For example, if you start with 10^9 identical
                            parent sequences and amplify them in an epPCR to 10^15 sequences, then
                            you have had about <i>d</i> = 20 doublings (10^9 &#xD7; 2^20 ~= 10^15), and
                            you can calculate <i>eff</i> = <i>d</i> &#xF7; <i>ncycles</i>. Actually the <i>d</i> =
                            <i>ncycles</i> &#xD7; <i>eff</i> formula
                            is wrong. The correct formula is 2^d = (1+eff)^ncycles, so that the efficiency
                            is given by eff = 2^(d/ncycles) - 1 (<a href="/cgi-bin/aef/PCReff.pl">PCR efficiency
                                calculator</a>).
                        </p>
                        <h3>References</h3>
                        <li>Drummond D.A., Iverson B.L., Georgiou G., Arnold F.H. (2005). Why high-error-rate
                            random mutagenesis libraries are enriched in functional and improved proteins, <i>J. Mol.
                                Biol.</i>,
                            <b>350</b>,
                            806-816.
                        </li>
                        <li>Firth A.E., Patrick W.M., (2005). Statistics of protein library construction, <i>Bioinformatics</i>,
                            <b>21</b>,
                            3314-3315.
                        </li>
                        <li>Sun F. (1995). The polymerase chain reaction and branching processes, <i>J. Comput.
                            Biol.</i>,
                            <b>2</b>,
                            63-86.
                        </li>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="pedelAA_exact_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&#xD7;</button>
                        <h4 class="modal-title">Notes about Cx estimations</h4>
                    </div>
                    <div class="modal-body">
                        <h2 id="pedelAA_exact">PEDEL-AA x = 0, 1 and 2 sub-library statistics</h2>
                        <p>For x = 0, 1 and 2, we calculate the expected number of distinct variants,
                            Cx, precisely. This calculation includes variants with multiple nucleotide
                            substitutions in the same codon.</p>
                        <p>The total number of each of the 64 codon types in the input sequence is
                            calculated. The 64 x 20 matrix of probabilities for each codon type mutating
                            to each amino acid type is calculated using the input nucleotide substitution
                            matrix and the input substitution rate.</p>
                        <p>For x = 0, 1 and 2 there are, respectively Vx_2 = 1, 19N and 361N(N-1)/2
                            total possible <a href="pedel-AA_variants.html">variants</a>
                            (i.e. N!/[x!(N-x)!]
                            19^x, where N is the length of the input sequence in codons). The probability
                            of the input sequence mutating to each of these possible variants is calculated
                            and renormalized by the respective probability sum P0, P1 or P2 (where
                            Px = Sum_{v_i in Vx_2} P(v_i)) to give the normalized probabilities Pn(v_i)
                            of the different variants within the respective sub-libraries Lx, rather
                            than within the whole library. The probability of a particular variant
                            v_i being present in the relevant sub-library Lx is given by 1 - exp(-Pn(v_i)
                            x Lx). These probabilities are quickly summed over all possible variants
                            using the codon counts. Computationally, this is very fast for x = 0, 1
                            and 2, but can take a few minutes for x = 3; hence the &apos;exact&apos;
                            calculation is not used on the webserver for x &gt;= 3. The sizes of the
                            sub-libraries Lx are determined separately for the Poisson and PCR distributions
                            as described in the <a href="pedel-AA-stats.html">notes on the PEDEL-AA algorithms</a>,
                            thus resulting in separate Cx estimates for the different distributions.</p>
                        <p>Ideally, for x &gt;= 3, we will enter the <a href="pedel-AA_CxLx.html">Cx ~

                            Lx</a> region. In this case all the individual Cx estimates, and the estimated
                            total number of distinct variants in the library C = C0 + C1 + C2 + ...,
                            will be fairly good. A warning is printed in the &apos;notes&apos; column
                            if there are any x &gt;= 3 values for which the Cx ~ Lx approximation may
                            not apply, in which case Cx is estimated with the formula Cx ~ Vx_1(1-exp(-Lx/Vx_1))
                            (i.e. ignoring, in these particular sub-libraries, any <a href="pedel-AA_variants.html">variants</a>
                            of
                            type Vx_2).</p>
                        <p>See also <a href="pedel-AA-stats.html">notes on the PEDEL-AA

                            algorithms</a>.</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="pedelAA_CxLx_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&#xD7;</button>
                        <h4 class="modal-title">Notes about Cx estimations</h4>
                    </div>
                    <div class="modal-body">
                        <h2 id="pedelAA_CxLx">PEDEL-AA Cx ~ Lx region</h2>
                        <p>When Lx &lt;&lt; Vx then Cx ~ Lx. For equiprobable variants this approximation
                            is good to 5% for Lx &lt; 0.1 Vx (see the mathematical
                            <a href="../notes.pdf">notes</a> on
                            PEDEL). For PEDEL-AA, we use this approximation when Lx &lt; 0.1 Vx_1 (the
                            number of &apos;easy-to-reach&apos; variants).</p>
                        <p>See also <a href="pedel-AA_exact.html">notes on the &apos;exact&apos;

                            calculations</a> and <a href="pedel-AA-stats.html">notes on the PEDEL-AA

                            algorithms</a>.</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="pedelAA_warningRx_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&#xD7;</button>
                        <h4 class="modal-title">Notes about Cx estimations</h4>
                    </div>
                    <div class="modal-body">
                        <h2 id="pedelAA__warningRx">PEDEL-AA Rx warning</h2>
                        <p>For x = 0, 1 and 2, we calculate the expected number of distinct variants,
                            Cx, <a href="pedel-AA_exact.html">precisely</a>. When Lx &lt; 0.1 Vx_1 (i.e.
                            for large x values), we use the <a href="pedel-AA_CxLx.html">Cx ~ Lx</a> approximation.
                            Sometimes using the criterion &apos;Lx &lt; 0.1 Vx_1&apos; to determine
                            whether or not we are in the &apos;Cx ~ Lx&apos; region is not sufficient.
                            This is indicated by the corresponding Rx value not being &lt; 0.1. In
                            this case the corresponding Cx value may be an overestimate.</p>
                        <p>See also <a href="pedel-AA_Rx.html">notes on the &apos;Rx &lt; 0.1&apos;

                            criterion</a> and
                            <a href="pedel-AA-stats.html">notes on the PEDEL-AA

                                algorithms</a>.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>