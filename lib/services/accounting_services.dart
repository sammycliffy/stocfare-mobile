import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountingServices {
  Future<dynamic> balanceSheet(
      cash,
      inventory,
      accountReceivable,
      prepaidExpenses,
      shortTermInvestments,
      totalCurrentAsset,
      longTermInvestment,
      propertyPlantAndEquipment,
      intangibleAssets,
      totalFixedAsset,
      totalAsset,
      accountPayable,
      shortTermLoans,
      incomeTaxesPayable,
      accruedSalariesAndWages,
      unearnedRevenue,
      totalCurrentLiabilities,
      longTermDebt,
      deferredIncomeTax,
      longTermOthers,
      totalLongTermLiabilities,
      ownersInvestment,
      retainedEarnings,
      ownersOthers,
      totalOwnersEquity,
      totalLiabilitiesAndOwnersEquity,
      grossProfitMargin,
      operatingProfitMargin,
      returnOnCapitalEmployed,
      currentRatio,
      workingCapital,
      shareHolderInvesment,
      financialGerring,
      year) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('businessId');
    String token = sharedPreferences.getString('token');
    final String url =
        GlobalConfiguration().get("balance-sheet") + '$branchId/';

    try {
      final http.Response response = await http
          .post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: json.encode(<String, dynamic>{
                "assets": {
                  "current_asset": {
                    "cash": cash,
                    "inventory": inventory,
                    "account_receivable": accountReceivable,
                    "prepaid_expenses": prepaidExpenses,
                    "short_time_investments": shortTermInvestments,
                    "total_current_asset": totalCurrentAsset
                  },
                  "non_current_asset": {
                    "long_time_investment": longTermInvestment,
                    "property_plan_and_equipment": propertyPlantAndEquipment,
                    "intangible_asset": intangibleAssets,
                    "total_fixed_asset": totalFixedAsset,
                  },
                  "total_assets": totalAsset
                },
                "liabilities_and_owners_equity": {
                  "current_liabilities": {
                    "account_payable": accountPayable,
                    "short_term_loans": shortTermLoans,
                    "current_tax_payable": incomeTaxesPayable,
                    "accured_salaries_and_wages": accruedSalariesAndWages,
                    "unearned_revenue": unearnedRevenue,
                    "total_current_liabilities": totalCurrentLiabilities,
                  },
                  "long_term_liabilities": {
                    "long_term_debt": longTermDebt,
                    "deferred_income_tax": deferredIncomeTax,
                    "others": longTermOthers,
                    "total_long_time_liabilities": totalLongTermLiabilities,
                  },
                  "equity": {
                    "owners_investment": ownersInvestment,
                    "retained_earnings": retainedEarnings,
                    "share_holders_investment": shareHolderInvesment,
                    "others": ownersOthers,
                    "total_owners_equity": totalOwnersEquity,
                  },
                  "total_liabilities_and_owners_equity":
                      totalLiabilitiesAndOwnersEquity
                },
                "common_financial_ratios": {
                  "gross_profit_margin": grossProfitMargin,
                  "operating_profit_margin": operatingProfitMargin,
                  "return_on_capital_employed": returnOnCapitalEmployed,
                  "current_ratio": currentRatio,
                  "working_capital": workingCapital,
                  "financial_gerring": financialGerring
                },
                "for_the_year": year
              }))
          .timeout(Duration(seconds: 25), onTimeout: () => null);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        String _error = '';
        print(response.body);
        Map result = json.decode(response.body);
        result.forEach((k, v) {
          _error = '$k ${v[0]}';
        });
        return _error;
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  Future<dynamic> cashFlow(
    year,
    cashAtBeginingOfYear,
    otherOperationReceipt,
    customer,
    inventory,
    administrativeExpenses,
    wagesSalaryExpenses,
    interest,
    incomeTaxes,
    otherOperations,
    netCashFlowOperations,
    salePropertyAndEquipment,
    collectionOfPrincipalOnLoans,
    saleOfInvestmentSecurities,
    otherReturns,
    purchaseOfPropertyandEquipment,
    makingLoanstoOtherEntities,
    purchaseOfInvestmentSecurities,
    otherInvestments,
    netCashInvestment,
    insuranceSupplies,
    borrowing,
    otherFinancialIncomeCash,
    repurchaseOfStock,
    dividends,
    repaymentOfLoans,
    otherFinancialOutgoingCash,
    netCashFlowFinancing,
    cashAtEndOfYear,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('businessId');
    String token = sharedPreferences.getString('token');
    final String url = GlobalConfiguration().get("cash-flow") + '$branchId/';
    String _error = '';
    try {
      final http.Response response = await http
          .post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: json.encode(<String, dynamic>{
                "operations": {
                  "cash_receipt_from": {
                    "customers": customer,
                    "other_operations": otherOperationReceipt
                  },
                  "cash_paid_for": {
                    "wages_and_salary_expenses": wagesSalaryExpenses,
                    "cash_paid_for_inventory": inventory,
                    "general_operating_and_administrative_expenses":
                        administrativeExpenses,
                    "interest": interest,
                    "income_taxes": incomeTaxes,
                    "other_operations": otherOperations
                  },
                  "net_cash_flow_from_operations": netCashFlowOperations
                },
                "investing_activities": {
                  "cash_receipt_from": {
                    "sale_of_property_and_equipment": salePropertyAndEquipment,
                    "collection_of_principal_of_loans":
                        collectionOfPrincipalOnLoans,
                    "sale_of_investment_securities": saleOfInvestmentSecurities,
                    "others_returns": otherReturns
                  },
                  "cash_paid_for": {
                    "purchase_of_property_and_equipment":
                        purchaseOfPropertyandEquipment,
                    "making_loans_to_other_entities":
                        makingLoanstoOtherEntities,
                    "purchase_of_investment_securities":
                        purchaseOfInvestmentSecurities,
                    "other_investments": otherInvestments,
                  },
                  "net_cash_flow_from_investments": netCashInvestment
                },
                "financial_activities": {
                  "cash_receipt_from": {
                    "insurance_of_stocks": insuranceSupplies,
                    "borrowing": borrowing,
                    "other_financial_incoming_cash": otherFinancialIncomeCash
                  },
                  "cash_paid_for": {
                    "repurchase_of_stock": repurchaseOfStock,
                    "dividends": dividends,
                    "repayment_of_loans": repaymentOfLoans,
                    "other_financial_outgoing_cash": otherFinancialOutgoingCash
                  },
                },
                "cash_at_the_end_of_the_year": cashAtEndOfYear,
                "net_cash_flow_from_financing": netCashFlowFinancing,
                "cash_at_the_beginning_of_the_year": cashAtBeginingOfYear,
                "for_the_year_ending": cashAtBeginingOfYear
              }))
          .timeout(Duration(seconds: 25), onTimeout: () => null);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        print(response.body);
        Map result = json.decode(response.body);
        result.forEach((k, v) {
          _error = '$k ${v[0]}';
        });
        return _error;
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }
}
