package sortables;

/**
 * Created by Nick on 2017-01-03.
 */
public class SortLongestToShortestWord extends SortBasedOnSomeCriterion<String> {
    private SortLongestToShortestWord() {}

    public static SortLongestToShortestWord newInstance() {
        return new SortLongestToShortestWord();
    }


    @Override
    public boolean isMoreOfAGivenExtreme(String candidate, String opponent) {
        // null is considered shorter than any String
        return opponent == null
                || (candidate != null
                    && candidate.length() > opponent.length());
    }
}
