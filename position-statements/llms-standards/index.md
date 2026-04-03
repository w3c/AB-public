<section id="abstract">

As Large Language Models (LLMs) become increasingly synonymous with “AI”, and are used by people within our community, we want to highlight considerations around different ways in which LLMs can be useful or problematic when it comes to leveraging them in standards work at W3C.

</section>

<section id="sotd">
		
This document summarizes the Advisory Board’s current thinking, as of 24 March 2026. New initiatives by the W3C Team on [AI & the Web](https://www.w3.org/reports/ai-web-impact/), various AI-related Working Groups such as the [WebML WG](https://www.w3.org/groups/wg/webmachinelearning/) and [GPU for the Web WG](https://www.w3.org/groups/wg/gpu/), and the [Web & AI Interest Group](https://www.w3.org/groups/ig/webai/) show that this conversation is timely.

</section>

<section>

# Where Benefits May Outweigh Risks

So far, LLMs have shown to benefit the standards process in several ways:

## Demos, Tests and Examples

When paired with deep domain expertise, LLM coding assistants can help to build proof-of-concept level demos or write tests of specific web platform features. The ability to quickly generate and show a group many examples during a meeting helps verify concepts faster, reduces manual effort, and makes discussions more productive.

## Interrogate, Spellcheck, Edit Standards

In addition to basic spellchecking, and editing, which are especially facilitative for our international community, LLMs can be used to ask questions about web standards to identify problems, gaps, and possibilities to improve.

## Brainstorming Names

New standards work often needs new names. Those names should be easy to understand while still fitting platform conventions and avoiding conflicts with existing terms. Because LLMs are trained on a very large sample of human language, they can be useful to use when trying to come up with human friendly names for novel concepts.

</section>

<section> 
	
# Where Risks May Outweigh Benefits

In some cases, there are serious risks.

First, there is a possibility of copyright infringement. As LLMs may be trained on copyrighted materials, even well-meaning contributions could create associated liability.

There could also be security risks. Providing Member Confidential information to LLMs could result in data leakage (we suggest particular caution with free products).

Sometimes there’s subtle incorrectness. LLM-generated text and code may contain subtle falsehoods, which are hard to spot and difficult to debug.

If a specification concerns something that does not yet exist, like [the decade-old debate of defining what the scope of a “view” is](https://hidde.blog/views/), LLMs are unlikely to be helpful, as they’re often trained on stale data that doesn’t necessarily incorporate the most recent discussions, especially if they took place over email or meetings.

Verbosity is a possible issue too. At W3C, we’ve always exchanged lengthy arguments, but if we automate writing them we could end up with more text that is less intentional and less meaningful. This can result in “second-hand burdening” that can thwart our community’s effectiveness.

W3C has a long tradition of scribing discussions manually. It lets us take a step back, and reflect on and interpret how a room understood a discussion. Fully outsourcing this to LLMs risks losing that tradition, and introduces risks of misattribution, biased attribution, factual incorrectness, and increase of minute length with irrelevancies.

Lastly, there is a climate impact. Production and usage of LLMs has a climate footprint (including energy and water use) that is disproportionately high, when compared to the production and usage of alternatives, such as manually writing text. As the web platform is built with [commitment to sustainability in mind](https://www.w3.org/TR/ethical-web-principles/#sustainable), it is worth considering this in the tools we use while developing the platform’s standards.

</section>

<section>
	
# Combining Accountability with Best Practices

Ultimately, each individual is responsible for their own output. Whether or not an LLM is used is a matter of personal choice — the work produced remains the responsibility of the person behind it.

When LLMs are used, we suggest implementing these guardrails:

- **Check before sharing**: thoroughly check all content for correctness, and ensure no unintended information has been included, and that any content attributed to a person, for instance in minutes, reflects what they actually said.
- **Clearly label LLM output**: when content is primarily output from an LLM, label it as such. This helps collaborators evaluate the content. For instance, introduce output with “I got the following from an AI:”.
- **Assume full responsibility for the content**: when content is (partially) output from an LLM, it is upon the person sharing the content to take responsibility for it.
- **Prefer smaller and more task-specific models over large and general-purpose models**: smaller models usually use less energy.
- **Embrace thoughtful discussions**: avoid using LLMs instead of deliberation. For instance, in asynchronous discussions, writing can help the thought process, while generating replies with an LLM would sidestep that process.

</section>
