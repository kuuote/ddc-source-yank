import { GatherArguments } from "https://deno.land/x/ddc_vim@v4.0.5/base/source.ts";
import { ensure, is } from "https://deno.land/x/ddc_vim@v4.0.5/deps.ts";
import { BaseSource, Item } from "https://deno.land/x/ddc_vim@v4.0.5/types.ts";

type Never = Record<PropertyKey, never>;

export class Source extends BaseSource<Never> {
  override async gather({ denops }: GatherArguments<Never>): Promise<Item[]> {
    const candidates = ensure(
      await denops.call("ddc#source#yank#get"),
      is.ArrayOf(is.String),
    );
    return candidates.map((word) => ({ word }));
  }

  override params(): Never {
    return {};
  }
}
