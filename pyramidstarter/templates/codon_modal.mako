<!--The JS is in static/sitewide.js-->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="CodonScheme"
id="scheme_modal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&#xD7;</span>
                </button>
                 <h4 class="modal-title" id="codon_title">Helper to plan degenerate codons</h4>
            </div>
            <div class="modal-body">
                <div class="row" id="codon_intro">
                    <div class="bs-callout bs-callout-warning">Under construction. The ones with question marks fail and this section.</div>
                     <h1>Description</h1>
This helper allows you to pick the most ideal degenerate codons. It comes
                    in two forms. You choose the required amino acids or you choose the codons
                    to inspect.</div>
                 <h3>By codon (<a data-toggle="collapse" href="#codon_bycodon"><i class="fas fa-caret-down" aria-hidden="true"></i> show</a>)

                    </h3>
                <div class="row collapse" id="codon_bycodon">
                    <div class="col-lg-4">
                        <div class="row">
                            <div class="input-group">
                                <div class="input-group-prepend"><span class="input-group-text">Codon</span></div>
                                <select class="selectpicker form-control"
                                aria-labelledby="codon_drop" id="codon_drop" title="Choose...">
                                    <option value="NNN" data-def="Generic scheme. Unbalanced and with 3/64 stop codons.">NNN</option>
                                    <option value="NNK" data-def="Common scheme, identical to NNS. Cuts the number of stop codons while still making tryptophan.">NNK</option>
                                    <option value="NNS" data-def="Common scheme, identical to NNK. Cuts the number of stop codons while still making a tryptophan">NNS</option>
                                    <option value="NAN" data-def="Gives charged amino acids of various sizes.">NAN</option>
                                    <option value="NTN" data-def="Gives hydrophobic residues.">NTN</option>
                                    <option value="NGN" data-def="Not generally empoyed alone: it yields GRWC &#x2014;note the glycine. hence the NSN codon.">NGN</option>
                                    <option value="NCN" data-def="Gives small residues, but not glycine.">NCN</option>
                                    <option value="NSN" data-def="Gives small redisues including glycine and cysteine">NSN</option>
                                    <option value="NDT" data-def="">NDT</option>
                                    <option value="DBK" data-def="">DBK</option>
                                    <option value="NRT" data-def="">NRT</option>
                                    <option data-divider="true"></option>
                                    <option value="19c" data-def="">??? (19c)</option>
                                    <option value="20c" data-def="">Tang (20c)</option>
                                    <option value="21c" data-def="">??? (21c)</option>
                                    <option value="22c" data-def="">Kille (22c)</option>
                                    <option data-divider="true"></option>
                                    <option value="other" data-def="">other...</option>
                                </select>
                                <br>
                            </div>
                        </div>
                        <div class="row">
                            <br>
                            <div id="codon_manual" hidden>
                                <div class="input-group">
                                    <div class="input-group-prepend" data-toggle="tooltip" title="The mutation used. The input is a string which can be simply four bases (e.g. &apos;NNK&apos;) or multiple codons separated by a space and optionally prefixed with a interger number denoting their ratios (e.g. &apos;12NDT 6VHA 1TGG 1ATG&apos;) or a special mix (e.g. &apos;Tang&apos;)."
                                    data-placement="top">
                                        <span class="input-group-text">Scheme</span>
                                    </div>
                                    <input type="text" class="form-control"
                                    placeholder="NNN" id="codon_mutation">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div id="codon_graph"></div>
                    </div>
                    <div id="codon_result"></div>
                </div>
                 <h3>By amino acids (<a data-toggle="collapse" href="#codon_byAA"><i class="fas fa-caret-down" aria-hidden="true"></i> show</a>)

                    </h3>
                <div class="row collapse" id="codon_byAA">
                    <p>This section would be cool if it had a negative option and stuff like,
                        hydrophobics use Z.</p>
                    <p>It sorts with a 2x penalty for stop and give precence to more equal distributions,
                        in case of a tie to less degenerate codons.</p>
                    <p>Accepts three letter code with first letter capital separated by a space,
                        or one letter with spaces or not &#x2014; corner case: SER is Ser + Asp
                        + Arg while Ser is Serine.</p>
                    <div class="col-lg-4">
                        <div class="input-group"> <div class="input-group-prepend" id="codonAA_list_addon">
                            <span class="input-group-text">Wanted AAs</span>
                        </div>
                            <input
                            type="text" class="form-control" placeholder="G P S" aria-describedby="codonAA_list_addon"
                            id="codonAA_list">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="input-group">
                            <div class="input-group-prepend" id="codonAA_antilist_addon">
                                <span class="input-group-text">Unwanted AAs</span>
                            </div>
                            <input
                            type="text" class="form-control" placeholder="C" aria-describedby="codonAA_antilist_addon"
                            id="codonAA_antilist">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="btn-group" role="group" aria-label="calculate">
                            <button type="button" class="btn btn-success" id="codonAA_calculate"><i class="fas fa-calculator"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-lg-12" id="codonAA_result"></div>
                </div>
            </div>
        </div>
    </div>
</div>