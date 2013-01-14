{include file="header.tpl"}

<div class="leftcolumn leaflet">
    <form id="frmUpload" method="post" action="{$form_action}">
        {include file="formvars.tpl"}
        <h1>Add an election</h1>
        <fieldset>
            <ul>
                <li>
                    <label for="txtName">Give the election a name *</label>
                    <input type="text" id="txtName" name="txtName" {if $warn_txtName}class="error"{/if} value="{$data.txtName}"/>
                    <small>e.g. Australian Federal Election 2010</small>
                </li>
                <li>
                    <label>What categories should the election have? *</label>
                    <ul class="scroll" id="category_list">
                        {foreach from="$categories" item="category"}
                            {assign var="checked" value=false}
                            {foreach from="$selected_category_ids" item="selected_category_id"}
                                {if $category->category_id == $selected_category_id}
                                    {assign var="checked" value=true}
                                {/if}
                            {/foreach}
                            <li>
                                <input type="checkbox" id="chkCategory_{$category->category_id}" name="chkCategory_{$category->category_id}" value="{$category->category_id}" {if $checked == true}checked="checked"{/if}/>
                                <label for="chkCategory_{$category->category_id}">{$category->name}</label>
                            </li>
                        {/foreach}
                    </ul>
                </li>
                 <li>
                    <label for="txtNewCat">Add a new category</label>
                    <input type="text" id="txtNewCat" name="txtNewCat"/>
                </li>
                <li>
                    <label for="ddlParties">Which parties are taking part? *</label>
                    <ul class="scroll">
                        {foreach from="$parties" item="party"}
                            {assign var="checked" value=false}
                            {foreach from="$selected_party_ids" item="selected_party_id"}
                                {if $party->party_id == $selected_party_id}
                                    {assign var="checked" value=true}
                                {/if}
                            {/foreach}
                            <li>
                                <input type="checkbox" id="chkParty{$party->party_id}" name="chkParty{$party->party_id}" value="{$party->party_id}" {if $checked == true}checked="checked"{/if}/>
                                <label for="chkParty{$party->party_id}">{$party->name}</label>
                            </li>
                        {/foreach}
                    </ul>
                </li>
                <!-- <li>
                    <label for="txtDescription">Enter a transcript of the main points / first paragraph</label>
                    <textarea type="text" id="txtDescription" name="txtDescription" {if $warn_txtDescription}class="error"{/if} cols="70" rows="5">{$data.txtDescription}</textarea>
                    <br/>
                    <strong>Note: please only add what is actually on the leaflet, not your opinion of it.</strong>
                </li>
                <li>
                    <label for="txtPostcode">Which postcode was the leaflet delivered to? *</label>
                    <input type="text" id="txtPostcode" name="txtPostcode" {if $warn_txtPostcode}class="error"{/if} value="{$data.txtPostcode}"/>
                    <small>this will let us work out which electorate the leaflet covers</small>
                </li>
                <li>
                    <label for="ddlConstituency">Which electorate was the leaflet delivered to?</label>
                    {if $constituencies_hints}
                        <ol {if $warn_ddlConstituency}class="error"{/if}>
                          {foreach from="$constituencies_hints" item="name"}
                          <li><input type="radio" name="ddlConstituencyHint" value="{$name}" {if $data.ddlConstituency == $name}selected="selected"{/if}>{$name}</li>
                          {/foreach}
                        </ol>
                    {else}
                    <select id="ddlConstituency" name="ddlConstituency" {if $warn_ddlConstituency}class="error"{/if}>
                        <option></option>
                        {foreach from="$constituencies" item="constituency"}
                            <option value="{$constituency->name}" {if $data.ddlConstituency == $constituency->name}selected="selected"{/if}>{$constituency->name}</option>
                        {/foreach}
                    </select>
                    {/if}
                    <small>please select one if we can't work out the electorate from the postcode alone</small>
                </li>
                <li>
                    <label for="ddlDelivered">When was the leaflet delivered? *</label>
                    <select id="ddlDelivered" name="ddlDelivered" {if $warn_ddlDelivered}class="error"{/if}>
                        <option value="0" {if $data.ddlDelivered == 0}selected="selected"{/if}>Today</option>
                        <option value="1" {if $data.ddlDelivered == 1}selected="selected"{/if}>Yesterday</option>
                        <option value="7" {if $data.ddlDelivered == 7}selected="selected"{/if}>Last Week</option>
                        <option value="14" {if $data.ddlDelivered == 14}selected="selected"{/if}>Couple of weeks ago</option>
                        <option value="30" {if $data.ddlDelivered == 30}selected="selected"{/if}>Last month</option>
                        <option value="60" {if $data.ddlDelivered == 60}selected="selected"{/if}>Two months ago</option>
                        <option value="90" {if $data.ddlDelivered == 60}selected="selected"{/if}>Three months ago</option>
                    </select>
                    <small class="highlight">Please only add leaflets that have been delivered to you recently</small>
                </li>
                <li>
                    <label>Which parties (if any) does the leaflet attack or criticise?</label>
                    <ul class="scroll">
                        {section name="party" loop="$parties"}
                            {assign var="checked" value=false}
                            {foreach from="$selected_party_attack_ids" item="selected_party_attack_id"}
                                {if $parties[party]->party_id == $selected_party_attack_id}
                                    {assign var="checked" value=true}
                                {/if}
                            {/foreach}
                            <li {if $parties[party]->major == 1 && $parties[party.index_next]->major !=1} class="divider" {/if}>
                                <input type="checkbox" id="chkPartyAttack_{$parties[party]->party_id}" name="chkPartyAttack_{$parties[party]->party_id}" value="{$parties[party]->party_id}" {if $checked == true}checked="checked"{/if}/>
                                <label for="chkPartyAttack_{$parties[party]->party_id}">{$parties[party]->name}</label>
                            </li>
                        {/section}
                    </ul>
                </li>
                <li>
                    <label for="txtTags">Tags this leaflet (candidate name, town, policy name, etc)</label>
                    <textarea type="text" id="txtTags" name="txtTags" {if $warn_txtTags}class="error"{/if} cols="70" rows="3">{$data.txtTags}</textarea>
                    <br/>
                    <small>e.g. infrastructure<span class="huge">,</span> Moore Park<span class="huge">,</span> John Alexander<span class="huge">,</span> Work Choices<span class="huge">,</span> mining</small>
                </li>
                <li>
                    <label for="txtName">Enter your name and email address *</label>
                    <input type="text" id="txtName" name="txtName" value="{$data.txtName}"/>
                    <input type="text" id="txtEmail" name="txtEmail" value="{$data.txtEmail}"/>
                    <small>Your email address will not be made public</small>
                </li> -->
            </ul>
        </fieldset>
        <div class="buttons">
            <input type="submit"  value="Create election"/>
        </div>
    </form>
</div>

{literal}
<script type="text/javascript">
$("#txtNewCat").click(function() {
    $("#category_list").append
    // $("#test").append('<li><input type="checkbox" id="chkCategory_12" name="chkCategory_12" value="12"><label for="chkCategory_12">Transport 2</label></li>');
});
</script>
{/literal}

{include file="footer.tpl"}