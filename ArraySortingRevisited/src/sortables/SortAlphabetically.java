package sortables;

/**
 * Created by Nick on 2017-01-03.
 */

// Can't use SortAscending since it does not generically ignore case when Strings are used
public class SortAlphabetically extends SortBasedOnSomeCriterion<String> {
    private SortAlphabetically() {}

    public static SortAlphabetically newInstance() {
        return new SortAlphabetically();
    }

    @Override
    public boolean isMoreOfAGivenExtreme(String candidate, String opponent) {
        return candidate != null
                && opponent != null
                && candidate.toLowerCase().compareTo(opponent.toLowerCase()) < 0;
    }
}
